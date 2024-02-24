import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const keyToPrivateKey = 'privateKey';
const keyToPublicKey = 'publicKey';
const keyToAccessToken = 'accessToken';
const keyToUserId = 'userid';
const keyToUsername = 'username';
const keyToExpireDate = 'expireDate';

class StorageProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  Future<String?> read({required String key}) async {
    return await storage.read(key: key);
  }

  Future<void> write({required String key, required String value}) async {
    await storage.write(key: key, value: value);
    notifyListeners();
  }
}

final storageProvider = ChangeNotifierProvider<StorageProvider>((ref) {
  return StorageProvider();
});
