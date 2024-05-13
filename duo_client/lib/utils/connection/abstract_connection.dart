import 'package:duo_client/pb/game.pb.dart';
import 'package:duo_client/pb/lobby.pb.dart';

abstract class AbstractServerConnection {
  LobbyStatus? lobbyStatus;
  GameState? gameState;
  StackState? stackState;
  PlayerState? playerState;

  AbstractServerConnection();

  // User management
  Future<int> registerUser(String username);
  Future<int> loginUser(String uuid);

  // Lobby management
  Future<int> createLobby(String token, int maxPlayers);
  Future<int> joinLobby(String token, int lobbyId);
  Future<int> disconnectLobby(String token, int lobbyId);

  // Game management
  Future<int> startGame(String token, String gameId);
  Future<int> getPlayerStream(String token, String gameId);
  Future<int> getStackStream(String token, String gameId);
  Future<int> streamPlayerAction(Stream<PlayerAction> action);
}
