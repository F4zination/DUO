import 'dart:html';

import 'package:duo_client/provider/storage_provider.dart';
import 'package:duo_client/utils/connection/abstract_connection.dart';
import 'package:duo_client/utils/connection/grpc_server_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ServerConnectionType {
  grpc,
}

class ApiProvider extends ChangeNotifier {
  AbstractServerConnection? serverConnection;
  StorageProvider? _storageProvider;

  ApiProvider(this._storageProvider);

  void init(ServerConnectionType type) {
    switch (type) {
      case ServerConnectionType.grpc:
        serverConnection = GrpcServerConnection();
        serverConnection!.init(notifyListeners, _storageProvider!);
        notifyListeners();
        break;
    }
  }
}

final apiProvider = ChangeNotifierProvider<ApiProvider>((ref) {
  return ApiProvider(ref.watch(storageProvider));
});
