import 'package:duo_client/pb/lobby.pb.dart';

abstract class AbstractServerConnection {
  LobbyStatus? lobbyStatus;

  AbstractServerConnection();
  Future<int> registerUser(String username);
  Future<int> loginUser(String uuid);
  Future<int> createLobby(String token, int maxPlayers);
  Future<int> joinLobby(String token, int sessionId);
  Future<int> disconnectLobby(String token, int sessionId);
}
