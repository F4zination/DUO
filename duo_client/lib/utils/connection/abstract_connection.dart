import 'package:duo_client/pb/friend.pb.dart';
import 'package:duo_client/pb/game.pb.dart';
import 'package:duo_client/pb/lobby.pb.dart';

abstract class AbstractServerConnection {
  LobbyStatus? lobbyStatus;
  GameState? gameState;
  StackState? stackState;
  PlayerState? playerState;
  bool? isStackOwner;
  int? gameId;

  AbstractServerConnection();

  Future<List<Friend>> getFriends(String token);
  Future<int> deleteFriend(String token, String friendId);
  Future<List<FriendRequest>> getFriendRequests(String token);
  Future<int> sendFriendRequest(String token, String friendId);
  Future<int> answerFriendRequest(
      String token, String requesterId, bool accept);

  // User management
  Future<int> registerUser(String username);
  Future<int> loginUser(String uuid);
  Future<int> initUserStatusStream();
  void sendUserstatusUpdate(String token, FriendState state);

  // Lobby management
  Future<int> createLobby(String token, int maxPlayers);
  Future<int> joinLobby(String token, int lobbyId);
  Future<int> disconnectLobby(String token, int lobbyId);
  Future<int> startGame(String token);

  // Notification management
  Future<int> getNotificationStream(String token);

  // Game management
  Future<int> getGameStateStream(String token, int gameId);
  Future<int> getPlayerStream(String token, int gameId);
  Future<int> getStackStream(String token, int gameId);
  Future<int> requestCard(String token, int gameId);
  Future<int> changeStackDevice(String token, String deviceId);
  Future<int> streamPlayerAction(PlayerAction action);

  bool get hasLobbyStream;
  bool get hasGameStream;
  bool get hasPlayerStream;
  bool get hasStackStream;
  bool get hasUserStatusStream;
  bool get hasNotificationStream;
}
