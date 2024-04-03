abstract class AbstractServerConnection {
  AbstractServerConnection();
  Future<int> registerUser(String username);
  Future<int> loginUser(String uuid);
  Future<int> createSession(String token, String pin);
  Future<int> joinSession(String token, int sessionId, String pin);
  Future<int> disconnectSession(String token, int sessionId);
}
