import 'dart:convert';
import 'dart:async';
import 'package:duo_client/pb/friend.pb.dart';
import 'package:duo_client/pb/lobby.pb.dart';
import 'package:duo_client/pb/notification.pb.dart' as notification;
import 'package:duo_client/pb/user_state.pb.dart';
import 'package:duo_client/pb/void.pb.dart';
import 'package:duo_client/utils/connection/server_events.dart';

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

  ResponseStream<LobbyStatus>? lobbyStream;
  ResponseStream<GameState>? gameStream;
  ResponseStream<PlayerState>? playerStream;
  ResponseStream<StackState>? stackStream;
  ResponseStream<notification.Notification>? notificationStream;
  StreamController<StatusChangeRequest>? userStatusStreamController;

  ResponseStream<void_>? userStatusAckStream;
  StreamController<PlayerAction> playerActionStreamController =
      StreamController<PlayerAction>.broadcast();

  StreamController<StackRequest>? stackRequestStreamController =
      StreamController<StackRequest>.broadcast();
  GrpcServerConnection({required String host}) : super() {
    channel = ClientChannel(
      host,
      port: Constants.port,
      //TODO make secure for release
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

      eventController.add(RegisterUserEvent(
        uuid: resp.uuid,
        username: username,
        accessToken: resp.authToken,
        privatePEMKey: privatePEMKey,
      ));
    } catch (e) {
      // If the registration fails, return -1
      return -1;
    }

    return 0;
  }

  /// Logs in a user with the server
  @override
  Future<int> loginUser(String uuid, String privateKey) async {
    String decryptedChallenge = '';

    ////////////////////////////////////////////
    // Request a login challenge from the server
    ////////////////////////////////////////////
    try {
      LoginChallengeRequest lcr =
          await client.requestLoginChallenge(LoginRequest(uuid: uuid));

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

      debugPrint('created token and expire date');
      eventController.add(LoginUserEvent(
        token: lr.token,
        expirationDate: lr.expiresAt.toDateTime(),
      ));
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
          // lobbyStatus = value;
          eventController.add(LobbyStatusEvent(value));
          //if game is starting
          if (value.isStarting == true) {
            debugPrint('received lobby status is starting == true');
            lobbyStream?.cancel();
            return;
          }
          //if is deleted
          if (value.isDeleted == true) {
            debugPrint('received lobby status is deleted');

            lobbyStream?.cancel();
            return;
          }
        },
        cancelOnError: true,
        onError: (e) {
          eventController.add(LobbyStatusDoneEvent());
          debugPrint('Error in Lobby Stream: $e');
        },
        onDone: () {
          eventController.add(LobbyStatusDoneEvent());
          lobbyStream = null;
          debugPrint('Lobby Stream Done');
        },
      );
    } catch (e) {
      debugPrint('Error in Lobby Stream: $e');
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
          eventController.add(LobbyStatusEvent(value));
          //if is starting
          if (value.isStarting == true) {
            lobbyStream?.cancel();
          }
          //if is deleted
          if (value.isDeleted == true) {
            debugPrint('received lobby status is deleted');

            lobbyStream?.cancel();
            lobbyStream = null;
          }
        },
        cancelOnError: true,
        onError: (e) {
          eventController.add(LobbyStatusDoneEvent());
          debugPrint('Error in Lobby Stream: $e');
          return -1;
        },
        onDone: () {
          eventController.add(LobbyStatusDoneEvent());
          lobbyStream = null;
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

      eventController.add(LobbyStatusDoneEvent());
      await lobbyStream?.cancel();
      lobbyStream = null;

      debugPrint('Lobby Stream Cancelled');

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
      //TODO[finn] check this: _notifyListeners();
    } catch (e) {
      return -1;
    }
    return 0;
  }

  @override
  Future<int> getPlayerStream(String token, int gameId) async {
    try {
      ResponseStream<PlayerState> stream =
          client.getPlayerStream(playerActionStreamController.stream);

      playerStream = stream;

      playerStream?.listen(
        (value) {
          // playerState = value;
          // _notifyListeners();
          debugPrint('Received Player State Event: $value');

          eventController.add(PlayerStateEvent(value));
        },
        cancelOnError: false,
        onError: (e) {
          eventController.add(PlayerStateDoneEvent());
          debugPrint('Error: $e');
        },
        onDone: () {
          // playerState = null;
          eventController.add(PlayerStateDoneEvent());
          gameStream = null;
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
      final responseStream =
          client.getStackStream(stackRequestStreamController!.stream,
              options: CallOptions(
                timeout: const Duration(days: 1),
              ));
      stackStream = responseStream;
      stackStream?.listen(
        (value) {
          eventController.add(StackStateEvent(value));
          debugPrint('card on top: ${value.placeStack.cardIdOnTop}');
          debugPrint('stack stream acknowledge received');
        },
        onError: (error) {
          stackStream?.cancel();
          stackStream = null;
          eventController.add(StackStateDoneEvent());
          debugPrint('Error establishing stack stream: $error');
        },
        onDone: () {
          debugPrint('Stack stream done');
          stackStream = null;
          eventController.add(StackStateDoneEvent());
        },
        cancelOnError: false,
      );

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
  Future<int> stackInit(String token, int gameId) async {
    if (!hasStackStream) {
      debugPrint('User status stream not established');
      return -1;
    }
    stackRequestStreamController!.add(StackRequest(
      token: token,
      gameId: gameId,
      drawingCard: false,
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

      gameStream = gameStateStream;

      gameStream?.listen(
        (value) {
          debugPrint('new game state: $value');
          eventController.add(GameStateEvent(value));
        },
        cancelOnError: true,
        onError: (e) {
          eventController.add(GameStateDoneEvent());
          debugPrint('Error: $e');
        },
        onDone: () {
          gameStream = null;
          eventController.add(GameStateDoneEvent());
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
            eventController.add(UserStatusAckEvent());
          }
        },
        onError: (error) {
          if (!streamEstablishedCompleter.isCompleted) {
            streamEstablishedCompleter.completeError(error);
            userStatusAckStream?.cancel();
            userStatusAckStream = null;
            eventController.add(UserStatusDoneEvent());
          }
          debugPrint('Error establishing user status stream: $error');
        },
        onDone: () {
          debugPrint('User status stream done');
          userStatusAckStream = null;
          eventController.add(UserStatusDoneEvent());
        },
        cancelOnError: true,
      );

      await streamEstablishedCompleter.future;
      eventController.add(UserStatusInitEvent());
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
      eventController.add(GetFriendsEvent(response.friends));
      return response.friends;
    } catch (e) {
      debugPrint('Error fetching friends: $e');
      return [];
    }
  }

  @override
  Future<int> sendFriendRequest(
      String token, String username, String friendId) async {
    try {
      debugPrint('Sending friend request to $friendId');
      await client.sendFriendRequest(FriendRequestRequest(
        requesterName: username,
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
          eventController.add(NotificationEvent(value));
          // _notificationProvider.addNotification(value);
          // _notifyListeners();
        },
        cancelOnError: true,
        onError: (e) {
          eventController.add(NotificationDoneEvent());
          debugPrint('Error: $e');
        },
        onDone: () {
          notificationStream = null;
          eventController.add(NotificationDoneEvent());
          debugPrint('Notification Stream Done');
        },
      );
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
