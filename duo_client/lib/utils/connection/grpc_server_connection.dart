import 'dart:convert';
import 'dart:async';
import 'package:duo_client/pb/lobby.pb.dart';
import 'package:duo_client/provider/storage_provider.dart';

import '../../pb/auth_messages.pb.dart';
import 'abstract_connection.dart';
import '../constants.dart';
import '../encryption/encryption_handler.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import '../../pb/duo_service.pbgrpc.dart';
import '../../pb/game.pb.dart';
import 'package:pointycastle/export.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

class GrpcServerConnection extends AbstractServerConnection {
  late final ClientChannel channel;
  late final DUOServiceClient client;
  late final VoidCallback _notifyListeners;
  final StorageProvider _storage;

  ResponseStream<LobbyStatus>? lobbyStream;
  ResponseStream<GameState>? gameStream;
  ResponseStream<PlayerState>? playerStream;
  ResponseStream<StackState>? stackStream;

  GrpcServerConnection(this._storage, this._notifyListeners) : super() {
    channel = ClientChannel(
      _storage.grpcHost,
      port: Constants.port,
      //TODO make secure
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    client = DUOServiceClient(channel);
  }

  /// Registers a user with the server
  @override
  Future<int> registerUser(String username) async {
    // Generate RSA key pair
    final (publicPEMKey, privatePEMKey) =
        await EncryptionHandler.createPemKeyPair();

    // Try to register the user with the server and store the private key and user id
    try {
      RegisterResponse resp = await client.register(RegisterRequest(
        username: username,
        publicKey: publicPEMKey,
      ));

      await _storage.setUsername(username);
      await _storage.setUserId(resp.uuid);
      await _storage.setAccessToken(resp.authToken);
      await _storage.setPrivateKey(privatePEMKey);
    } catch (e) {
      // If the registration fails, return -1
      return -1;
    }

    return 0;
  }

  /// Logs in a user with the server
  @override
  Future<int> loginUser(String uuid) async {
    String decryptedChallenge = '';

    ////////////////////////////////////////////
    // Request a login challenge from the server
    ////////////////////////////////////////////
    try {
      LoginChallengeRequest lcr =
          await client.requestLoginChallenge(LoginRequest(uuid: uuid));

      String privateKey = _storage.privateKey;
      var helper = RsaKeyHelper();

      RSAPrivateKey privKey = helper.parsePrivateKeyFromPem(privateKey);

      var decodedChallenge = base64.decode(lcr.challenge);
      var decodedChallengeString = String.fromCharCodes(decodedChallenge);

      decryptedChallenge = decrypt(
        decodedChallengeString,
        privKey,
      );

      decryptedChallenge =
          decryptedChallenge.substring(decryptedChallenge.length - 32);
    } catch (e) {
      return -1;
    }
    ////////////////////////////////////////////
    //  Submit the decrypted challenge to the server
    ////////////////////////////////////////////
    try {
      LoginResponse lr =
          await client.submitLoginChallenge(LoginChallengeResponse(
        uuid: uuid,
        decryptedChallenge: decryptedChallenge,
      ));

      await _storage.setExpireDate(lr.expiresAt.toDateTime());
      await _storage.setAccessToken(lr.token);
    } catch (e) {
      return -1;
    }

    // If the login was successful, return 0

    return 0;
  }

  @override
  Future<int> createLobby(String token, int maxPlayers) async {
    try {
      ResponseStream<LobbyStatus> stream = client.createLobby(
          CreateLobbyRequest(maxPlayers: maxPlayers, token: token));

      lobbyStream = stream;
      debugPrint(lobbyStream.toString());

      lobbyStream?.listen(
        (value) {
          lobbyStatus = value;
          _notifyListeners();
        },
        cancelOnError: true,
        onError: (e) {
          debugPrint('Error: $e');
        },
        onDone: () {
          lobbyStatus = null;
          lobbyStream = null;
          _notifyListeners();
          debugPrint('Lobby Stream Done');
        },
      );
    } catch (e) {
      print('Error: $e');
      return -1;
    }
    return 0;
  }

  @override
  Future<int> joinLobby(String token, int lobbyId) async {
    try {
      debugPrint(lobbyStream.toString());

      ResponseStream<LobbyStatus> stream = client.joinLobby(JoinLobbyRequest(
        token: token,
        lobbyId: lobbyId,
      ));
      lobbyStream = stream;

      lobbyStream?.listen(
        (value) {
          lobbyStatus = value;
          _notifyListeners();
        },
        cancelOnError: true,
        onError: (e) {
          debugPrint('Error: $e');
          return -1;
        },
        onDone: () {
          lobbyStatus = null;
          lobbyStream = null;
          _notifyListeners();
          debugPrint('Lobby Stream Done');
        },
      );
    } catch (e) {
      return -1;
    }
    return 0;
  }

  @override
  Future<int> disconnectLobby(String token, int lobbyId) async {
    try {
      //TODO delete disconnect call from Proto DuoService
      // DisconnectLobbyResponse res =
      //     await client.disconnectLobby(DisconnectLobbyRequest(
      //   token: token,
      //   lobbyId: lobbyId,
      // ));
      // debugPrint('Response: ${res.success}');

      await lobbyStream?.cancel();
      lobbyStatus = null;
      lobbyStream = null;

      debugPrint('Lobby Stream Cancelled');

      _notifyListeners();

      return 0;
    } catch (e) {
      return -1;
    }
  }

  @override
  Future<int> startGame(String token, String gameId) async {
    try {
      ResponseStream<GameState> gameStream = client.startGame(StartGameRequest(
        token: token,
        gameId: gameId,
      ));

      await for (GameState gs in gameStream) {
        gameState = gs;
        _notifyListeners();
      }
    } catch (e) {
      return -1;
    }
    return 0;
  }

  @override
  Future<int> getPlayerStream(String token, String gameId) async {
    try {
      ResponseStream<PlayerState> playerStream =
          client.getPlayerStream(GetPlayerStateRequest(
        token: token,
        gameId: gameId,
      ));

      await for (PlayerState ps in playerStream) {
        playerState = ps;
        _notifyListeners();
      }
    } catch (e) {
      return -1;
    }
    return 0;
  }

  @override
  Future<int> getStackStream(String token, String gameId) async {
    try {
      ResponseStream<StackState> stackStream =
          client.getStackStream(GetStackStateRequest(
        token: token,
        gameId: gameId,
      ));

      await for (StackState ss in stackStream) {
        stackState = ss;
        _notifyListeners();
      }
    } catch (e) {
      return -1;
    }
    return 0;
  }

  @override
  Future<int> streamPlayerAction(Stream<PlayerAction> action) async {
    try {
      await client.streamPlayerActions(action);
    } catch (e) {
      return -1;
    }
    return 0;
  }
}
