import 'dart:convert';
import 'dart:async';
import 'package:duo_client/pb/friend.pb.dart';
import 'package:duo_client/pb/lobby.pb.dart';
import 'package:duo_client/pb/notification.pb.dart' as notification;
import 'package:duo_client/pb/user_state.pb.dart';
import 'package:duo_client/pb/void.pb.dart';
import 'package:duo_client/provider/notification_provider.dart';
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
  final NotificationProvider _notificationProvider;

  ResponseStream<LobbyStatus>? lobbyStream;
  ResponseStream<GameState>? gameStream;
  ResponseStream<PlayerState>? playerStream;
  ResponseStream<StackState>? stackStream;
  ResponseStream<notification.Notification>? notificationStream;
  StreamController<StatusChangeRequest>? userStatusStreamController;

  ResponseStream<void_>? userStatusAckStream;
  Stream<PlayerAction> playerActionStream = const Stream.empty();
  StreamController<PlayerAction> playerActionStreamController =
      StreamController<PlayerAction>.broadcast();

  // Stream<StackRequest> stackRequestStream = const Stream.empty();
  StreamController<StackRequest>? stackRequestStreamController;
  GrpcServerConnection(
      this._storage, this._notificationProvider, this._notifyListeners)
      : super() {
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
            gameId = -2;
            lobbyStatus = null;
            lobbyStream?.cancel();
            _notifyListeners();
            return;
          }
          _notifyListeners();
        },
        cancelOnError: true,
        onError: (e) {
          debugPrint('Error in Lobby Stream: $e');
        },
        onDone: () {
          lobbyStatus = null;
          lobbyStream = null;
          _notifyListeners();
          debugPrint('Lobby Stream Done');
        },
      );
    } catch (e) {
      print('Error in Lobby Stream: $e');
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
          debugPrint('Error in Lobby Stream: $e');
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
      await client.startGame(TokenOnlyRequest(
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
  Future<int> streamPlayerAction(PlayerAction action) async {
    playerActionStreamController.add(action);
    return 0;
  }

  @override
  Future<int> getStackStream(String token, int gameId) async {
    try {
      final streamEstablishedCompleter = Completer<void>();
      if (!hasStackStream) {
        stackRequestStreamController = StreamController<StackRequest>.broadcast(
          onCancel: () =>
              debugPrint('Stream controller for stack request cancelled'),
        );
        _notifyListeners();
      }
      final responseStream =
          client.getStackStream(stackRequestStreamController!.stream,
              options: CallOptions(
                timeout: const Duration(days: 1),
              ));
      stackStream = responseStream;
      stackStream?.listen(
        (_) {
          if (!streamEstablishedCompleter.isCompleted) {
            if (!streamEstablishedCompleter.isCompleted) {
              streamEstablishedCompleter.complete();
            }
            debugPrint('stack stream acknowledge received');
          }
        },
        onError: (error) {
          if (!streamEstablishedCompleter.isCompleted) {
            streamEstablishedCompleter.completeError(error);
            stackStream?.cancel();
            stackStream = null;
            _notifyListeners();
          }
          debugPrint('Error establishing stack stream: $error');
        },
        onDone: () {
          debugPrint('Stack stream done');
          stackStream = null;
          _notifyListeners();
        },
        cancelOnError: false,
      );

      await streamEstablishedCompleter.future;
      _notifyListeners();
      return 0;
    } catch (e) {
      debugPrint('Error sending stack request: $e');
      return -1;
    }
  }

  @override
  Future<int> requestCard(String token, int gameId) async {
    if (!hasStackStream) {
      debugPrint('User status stream not established');
      return -1;
    }
    stackRequestStreamController!.add(StackRequest(
      token: token,
      gameId: gameId,
    ));
    return 0;
  }

  @override
  Future<int> getGameStateStream(String token, int gameId) async {
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
      return -1;
    }
    return 0;
  }

  @override
  Future<int> initUserStatusStream() async {
    debugPrint('Has User Status Stream: $hasUserStatusStream');
    try {
      final streamEstablishedCompleter = Completer<void>();
      if (!hasUserStatusStream) {
        userStatusStreamController =
            StreamController<StatusChangeRequest>.broadcast(
          onCancel: () =>
              debugPrint('Stream controller for user status update cancelled'),
        );
        _notifyListeners();
      }
      final responseStream =
          client.statusChangeStream(userStatusStreamController!.stream,
              options: CallOptions(
                timeout: const Duration(days: 1),
              ));
      userStatusAckStream = responseStream;
      userStatusAckStream?.listen(
        (_) {
          if (!streamEstablishedCompleter.isCompleted) {
            if (!streamEstablishedCompleter.isCompleted) {
              streamEstablishedCompleter.complete();
            }
            debugPrint('User status stream acknowledge received');
          }
        },
        onError: (error) {
          if (!streamEstablishedCompleter.isCompleted) {
            streamEstablishedCompleter.completeError(error);
            userStatusAckStream?.cancel();
            userStatusAckStream = null;
            _notifyListeners();
          }
          debugPrint('Error establishing user status stream: $error');
        },
        onDone: () {
          debugPrint('User status stream done');
          userStatusAckStream = null;
          _notifyListeners();
        },
        cancelOnError: true,
      );

      await streamEstablishedCompleter.future;
      _notifyListeners();
      return 0;
    } catch (e) {
      debugPrint('Error sending userstatus update: $e');
      return -1;
    }
  }

  @override
  void sendUserstatusUpdate(String token, FriendState state) {
    if (!hasUserStatusStream) {
      debugPrint('User status stream not established');
      return;
    }
    userStatusStreamController!.add(StatusChangeRequest(
      token: token,
      status: state,
    ));
  }

  @override
  Future<int> answerFriendRequest(
      String token, String requesterId, bool accept) async {
    try {
      await client.sendFriendRequestResponse(FriendRequestResponse(
        token: token,
        requesterId: requesterId,
        accept: accept,
      ));
      return 0;
    } catch (e) {
      debugPrint('Error answering friend request: $e');
      return -1;
    }
  }

  @override
  Future<int> deleteFriend(String token, String friendId) async {
    try {
      client.deleteFriend(DeleteFriendRequest(
        token: token,
        targetId: friendId,
      ));
      return 0;
    } catch (e) {
      debugPrint('Error deleting friend: $e');
      return -1;
    }
  }

  @override
  Future<List<FriendRequest>> getFriendRequests(String token) async {
    try {
      FriendRequestList response =
          await client.getFriendRequests(TokenOnlyRequest(
        token: token,
      ));
      return response.requests;
    } catch (e) {
      debugPrint('Error fetching friend requests: $e');
      return [];
    }
  }

  @override
  Future<List<Friend>> getFriends(String token) async {
    try {
      FriendList response = await client.getFriendList(TokenOnlyRequest(
        token: token,
      ));
      return response.friends;
    } catch (e) {
      debugPrint('Error fetching friends: $e');
      return [];
    }
  }

  @override
  Future<int> sendFriendRequest(String token, String friendId) async {
    try {
      debugPrint('Sending friend request to $friendId');
      await client.sendFriendRequest(FriendRequestRequest(
        requesterName: _storage.username,
        token: token,
        targetId: friendId,
      ));
      return 0;
    } catch (e) {
      debugPrint('Error sending friend request: $e');
      return -1;
    }
  }

  @override
  Future<int> getNotificationStream(String token) async {
    try {
      ResponseStream<notification.Notification> stream =
          client.getNotificationStream(TokenOnlyRequest(
        token: token,
      ));
      notificationStream = stream;
      notificationStream!.listen(
        (value) {
          _notificationProvider.addNotification(value);
          _notifyListeners();
        },
        cancelOnError: true,
        onError: (e) {
          debugPrint('Error: $e');
        },
        onDone: () {
          debugPrint('Notification Stream Done');
        },
      );
      _notifyListeners();
    } catch (e) {
      return -1;
    }

    return 0;
  }

  @override
  bool get hasGameStream => gameStream != null;

  @override
  bool get hasLobbyStream => lobbyStream != null;

  @override
  bool get hasPlayerStream => playerStream != null;

  @override
  bool get hasStackStream =>
      stackStream != null && stackRequestStreamController != null;

  @override
  bool get hasUserStatusStream =>
      userStatusAckStream != null && userStatusStreamController != null;

  @override
  bool get hasNotificationStream => notificationStream != null;
}
