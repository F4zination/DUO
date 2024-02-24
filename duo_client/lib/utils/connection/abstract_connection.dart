abstract class AbstractServerConnection {
  void init();
  Future<int> registerUser(String username);
  Future<int> loginUser(String uuid);
}
