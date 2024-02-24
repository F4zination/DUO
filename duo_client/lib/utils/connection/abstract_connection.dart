abstract class AbstractServerConnection {
  void init();
  Future<int> registerUser(String username);
  Future<int> loginUser(String uuid);
  Future<int> createSession(String token, int pin);
  Future<int> joinSession(String token, int sessionId, int pin);
  Future<int> disconnectSession(String token, int sessionId);
  Future<int> deleteSession(String token, int sessionId);
}
