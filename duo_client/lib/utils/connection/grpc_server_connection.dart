import 'dart:convert';
import 'dart:async';
import 'dart:developer';
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
  Stream<PlayerAction> playerActionStream = Stream.empty();
  StreamController<PlayerAction> playerActionStreamController =
      StreamController<PlayerAction>.broadcast();

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
      debugPrint('created token and expire date');
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
          //if game is starting
          if (lobbyStatus?.isStarting == true) {
            debugPrint('received lobby status is starting == true');
            gameId = lobbyStatus?.gameId;
            isStackOwner = lobbyStatus?.users
                    .firstWhere((element) => element.isStack)
                    .uuid ==
                _storage.userId;
            _notifyListeners();
            lobbyStatus = null;
            lobbyStream?.cancel();
            _notifyListeners();
            return;
          }
          //if is deleted
          if (lobbyStatus?.isDeleted == true) {
            debugPrint('received lobby status is deleted');
            lobbyStatus = null;
            lobbyStream?.cancel();
            _notifyListeners();
            return;
          }
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
          //if is starting
          if (lobbyStatus?.isStarting == true) {
            gameId = lobbyStatus?.gameId;
            _notifyListeners();
            isStackOwner = lobbyStatus?.users
                    .firstWhere((element) => element.isStack)
                    .uuid ==
                _storage.userId;
            _notifyListeners();
            lobbyStatus = null;
            lobbyStream?.cancel();
            _notifyListeners();
          }
          //if is deleted
          if (lobbyStatus?.isDeleted == true) {
            debugPrint('received lobby status is deleted');
            lobbyStatus = null;
            lobbyStream?.cancel();
            lobbyStream = null;
            _notifyListeners();
          }
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
  Future<int> startGame(String token) async {
    try {
      debugPrint('Starting game...');
      await client.startGame(StartGameRequest(
        token: token,
      ));
    } catch (e) {
      debugPrint('Error: $e');
      return -1;
    }
    debugPrint('Game started');
    return 0;
  }

  @override
  Future<int> changeStackDevice(String token, String deviceId) async {
    try {
      await client.changeStackDevice(ChangeStackDeviceRequest(
        token: token,
        userUuid: deviceId,
      ));
      _notifyListeners();
    } catch (e) {
      return -1;
    }
    return 0;
  }

  @override
  Future<int> getPlayerStream(String token, int gameId) async {
    try {
      ResponseStream<PlayerState> playerStream =
          client.getPlayerStream(playerActionStream);

      playerStream.listen(
        (value) {
          playerState = value;
          _notifyListeners();
        },
        cancelOnError: true,
        onError: (e) {
          debugPrint('Error: $e');
        },
        onDone: () {
          playerState = null;
          gameStream = null;
          _notifyListeners();
          debugPrint('Player Stream Done');
        },
      );
    } catch (e) {
      return -1;
    }
    return 0;
  }

  @override
  Future<int> getStackStream(String token, int gameId) async {
    // try {
    //   ResponseStream<StackState> stackStream =
    //       client.getStackStream(GetStackStateRequest(
    //     token: token,
    //     gameId: gameId,
    //   ));

    //   await for (StackState ss in stackStream) {
    //     stackState = ss;
    //     _notifyListeners();
    //   }
    // } catch (e) {
    //   return -1;
    // }
    return 0;
  }

  @override
  Future<int> streamPlayerAction(PlayerAction action) async {
    playerActionStreamController.add(action);
    return 0;
  }

  @override
  Future<int> getGameStateStream(String token, int gameId) {
    // TODO: implement getGameStateStream
    try {
      ResponseStream<GameState> gameStateStream =
          client.getGameState(GetGameStateRequest(
        token: token,
        gameId: gameId,
      ));

      gameStateStream.listen(
        (value) {
          gameState = value;
          _notifyListeners();
        },
        cancelOnError: true,
        onError: (e) {
          debugPrint('Error: $e');
        },
        onDone: () {
          gameState = null;
          gameStream = null;
          _notifyListeners();
          debugPrint('Game Stream Done');
        },
      );
    } catch (e) {
      return Future(() => -1);
    }
    return Future(() => 0);
  }

  @override
  bool get hasGameStream => gameStream != null;

  @override
  bool get hasLobbyStream => lobbyStream != null;

  @override
  bool get hasPlayerStream => playerStream != null;

  @override
  bool get hasStackStream => stackStream != null;
}
