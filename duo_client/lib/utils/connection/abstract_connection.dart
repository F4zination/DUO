abstract class AbstractServerConnection {
  void init();
  Future<int> registerUser(String username);
  Future<int> loginUser(String uuid);
}

const keyToPrivateKey = 'privateKey';
const keyToPublicKey = 'publicKey';
const keyToAccessToken = 'accessToken';
