import 'package:duo_client/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageProvider extends ChangeNotifier {
  static const _keyToPrivateKey = 'privateKey';
  static const _keyToAccessToken = 'accessToken';
  static const _keyToUserId = 'userid';
  static const _keyToUsername = 'username';
  static const _keyToExpireDate = 'expireDate';
  static const _keyToIsFirstTime = 'isFirstTime';

  final _storage = const FlutterSecureStorage();

  ServerConnectionType _lastSelectedConnectionType = ServerConnectionType.grpc;
  String _userId = "";
  String _username = "";
  String _accessToken = "";
  DateTime? _expireDate;
  String _privateKey = "";
  bool _isFirstTime = true;
  String _grpcHost = "";

  StorageProvider();

  Future<void> init() async {
    await dotenv.load(fileName: ".env");
    _grpcHost = dotenv.get('GRPC_HOST');
    _userId = await _read(key: _keyToUserId) ?? "";
    _username = await _read(key: _keyToUsername) ?? "";
    _accessToken = await _read(key: _keyToAccessToken) ?? "";
    _expireDate = DateTime.tryParse(await _read(key: _keyToExpireDate) ?? "");
    _privateKey = await _read(key: _keyToPrivateKey) ?? "";
    _isFirstTime = ((await _read(key: _keyToIsFirstTime)) ?? "true") == "true";
  }

  Future<void> setIsFirstTime(bool isFirstTime) async {
    _isFirstTime = isFirstTime;
    await _write(key: _keyToIsFirstTime, value: isFirstTime.toString());
  }

  Future<void> setUserId(String userId) async {
    _userId = userId;
    await _write(key: _keyToUserId, value: userId);
  }

  Future<void> setUsername(String username) async {
    _username = username;
    await _write(key: _keyToUsername, value: username);
  }

  Future<void> setAccessToken(String accessToken) async {
    _accessToken = accessToken;
    await _write(key: _keyToAccessToken, value: accessToken);
  }

  Future<void> setExpireDate(DateTime expireDate) async {
    _expireDate = expireDate;
    await _write(key: _keyToExpireDate, value: expireDate.toString());
  }

  Future<void> setPrivateKey(String privateKey) async {
    _privateKey = privateKey;
    await _write(key: _keyToPrivateKey, value: privateKey);
  }

  void setLastSelectedConnectionType(ServerConnectionType type) {
    _lastSelectedConnectionType = type;
  }

  ServerConnectionType get lastSelectedConnectionType {
    return _lastSelectedConnectionType;
  }

  String get grpcHost {
    return _grpcHost;
  }

  bool get isFirstTime {
    return _isFirstTime;
  }

  String get userId {
    return _userId;
  }

  String get username {
    return _username;
  }

  String get accessToken {
    return _accessToken;
  }

  DateTime? get expireDate {
    return _expireDate;
  }

  String get privateKey {
    return _privateKey;
  }

  Future<String?> _read({required String key}) async {
    return await _storage.read(key: key);
  }

  Future<void> _write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
    notifyListeners();
  }
}

final storageProvider = ChangeNotifierProvider<StorageProvider>((ref) {
  return StorageProvider();
});
