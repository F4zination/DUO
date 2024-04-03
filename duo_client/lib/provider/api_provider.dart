import 'storage_provider.dart';
import '../utils/connection/abstract_connection.dart';
import '../utils/connection/grpc_server_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ServerConnectionType {
  grpc,
  bluetooth,
}

class ApiProvider extends ChangeNotifier implements AbstractServerConnection {
  AbstractServerConnection? _serverConnection;
  final StorageProvider _storageProvider;

  ApiProvider(this._storageProvider) {
    init(_storageProvider.lastSelectedConnectionType); //Defaults to grpc
  }

  void init(ServerConnectionType type) {
    _storageProvider.setLastSelectedConnectionType(type);
    switch (type) {
      case ServerConnectionType.grpc:
        _serverConnection =
            GrpcServerConnection(_storageProvider, notifyListeners);
        break;
      case ServerConnectionType.bluetooth:
        //TODO implement bluetooth connection
        break;
    }
    notifyListeners();
  }

  Future<String> getToken() async {
    if (_storageProvider.expireDate?.isBefore(DateTime.now()) ?? false) {
      await _serverConnection!.loginUser(_storageProvider.userId);
    }
    return _storageProvider.accessToken;
  }

  @override
  Future<int> createSession(String token, String pin) {
    return _serverConnection!.createSession(token, pin);
  }

  @override
  Future<int> disconnectSession(String token, int sessionId) {
    return _serverConnection!.disconnectSession(token, sessionId);
  }

  @override
  Future<int> joinSession(String token, int sessionId, String pin) {
    return _serverConnection!.joinSession(token, sessionId, pin);
  }

  @override
  Future<int> loginUser(String uuid) {
    return _serverConnection!.loginUser(uuid);
  }

  @override
  Future<int> registerUser(String username) {
    return _serverConnection!.registerUser(username);
  }
}

final apiProvider = ChangeNotifierProvider<ApiProvider>((ref) {
  return ApiProvider(ref.watch(storageProvider));
});
