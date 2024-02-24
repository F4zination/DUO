import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageKeys {
  String keyToUuid = 'userid';
  String keyToPrivateKey = 'privatekey';
  String keyToAccessToken = 'accesstoken';
  String keyToPublicKey = 'publickey';
}

class StorageProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  Future<String?> read({required String key}) async {
    return await storage.read(key: key);
  }
}
