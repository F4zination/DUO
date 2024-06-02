import 'package:duo_client/pb/friend.pb.dart';
import 'package:duo_client/pb/lobby.pb.dart';
import 'package:duo_client/pb/game.pb.dart';
import 'package:duo_client/provider/friend_provider.dart';
import 'package:duo_client/provider/notification_provider.dart';
import 'package:flutter/widgets.dart';

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
  final FriendProvider _friendProvider;
  final NotificationProvider _notificationProvider;

  @override
  LobbyStatus? get lobbyStatus => _serverConnection?.lobbyStatus;

  @override
  StackState? get stackState => _serverConnection?.stackState;

  @override
  PlayerState? get playerState => _serverConnection?.playerState;

  @override
  GameState? get gameState => _serverConnection?.gameState;

  ApiProvider(
      this._storageProvider, this._notificationProvider, this._friendProvider) {
    init(_storageProvider.lastSelectedConnectionType); //Defaults to grpc
  }

  void init(ServerConnectionType type) {
    _storageProvider.setLastSelectedConnectionType(type);
    switch (type) {
      case ServerConnectionType.grpc:
        _serverConnection = GrpcServerConnection(_storageProvider,
            _notificationProvider, _friendProvider, notifyListeners);
        break;
      case ServerConnectionType.bluetooth:
        //maybe implement bluetooth connection
        break;
    }
    notifyListeners();
  }

  Future<String> getToken() async {
    if (_storageProvider.expireDate
            ?.isBefore(DateTime.now().subtract(const Duration(minutes: 2))) ??
        false) {
      await _serverConnection!.loginUser(_storageProvider.userId);
      return _storageProvider.accessToken;
    }
    return _storageProvider.accessToken;
  }

  @override
  Future<int> createLobby(String token, int maxPlayers) {
    return _serverConnection!.createLobby(token, maxPlayers);
  }

  @override
  Future<int> disconnectLobby(String token, int lobbyId) {
    return _serverConnection!.disconnectLobby(token, lobbyId);
  }

  @override
  Future<int> joinLobby(String token, int lobbyId) {
    return _serverConnection!.joinLobby(token, lobbyId);
  }

  @override
  Future<int> loginUser(String uuid) {
    return _serverConnection!.loginUser(uuid);
  }

  @override
  Future<int> registerUser(String username) {
    return _serverConnection!.registerUser(username);
  }

  @override
  Future<int> startGame(String token) {
    return _serverConnection!.startGame(token);
  }

  @override
  Future<int> getPlayerStream(String token, int gameId) {
    return _serverConnection!.getPlayerStream(token, gameId);
  }

  @override
  Future<int> changeStackDevice(String token, String deviceId) {
    return _serverConnection!.changeStackDevice(token, deviceId);
  }

  @override
  Future<int> getStackStream(String token, int gameId) {
    return _serverConnection!.getStackStream(token, gameId);
  }

  @override
  Future<int> requestCard(String token, int gameId) async {
    if (hasStackStream == false) {
      debugPrint('No Stack Stream');
      final statusCode = await getStackStream(token, gameId);
      if (statusCode != 0) return statusCode;
    }
    return _serverConnection!.requestCard(token, gameId);
  }

  @override
  Future<int> streamPlayerAction(PlayerAction action) {
    return _serverConnection!.streamPlayerAction(action);
  }

  @override
  Future<int> getGameStateStream(String token, int gameId) {
    return _serverConnection!.getGameStateStream(token, gameId);
  }

  @override
  Future<int> initUserStatusStream() async {
    debugPrint('Init User Status Stream');
    final response = await _serverConnection!.initUserStatusStream();
    debugPrint('User Status Stream: $hasUserStatusStream');
    // notifyListeners();
    return response;
  }

  @override
  void sendUserstatusUpdate(String token, FriendState state) async {
    if (hasUserStatusStream == false) {
      debugPrint('No User Status Stream');
      await initUserStatusStream();
    }
    _serverConnection!.sendUserstatusUpdate(token, state);
  }

  @override
  Future<int> answerFriendRequest(
      String token, String requesterId, bool accept) {
    return _serverConnection!.answerFriendRequest(token, requesterId, accept);
  }

  @override
  Future<int> deleteFriend(String token, String friendId) {
    return _serverConnection!.deleteFriend(token, friendId);
  }

  @override
  Future<List<FriendRequest>> getFriendRequests(String token) {
    return _serverConnection!.getFriendRequests(token);
  }

  @override
  Future<List<Friend>> getFriends(String token) {
    return _serverConnection!.getFriends(token);
  }

  @override
  Future<int> sendFriendRequest(String token, String friendId) {
    return _serverConnection!.sendFriendRequest(token, friendId);
  }

  @override
  Future<int> getNotificationStream(String token) {
    return _serverConnection!.getNotificationStream(token);
  }

  @override
  set playerState(PlayerState? _playerState) {}

  @override
  set stackState(StackState? _stackState) {}

  @override
  set lobbyStatus(LobbyStatus? _lobbyStatus) {}

  @override
  set gameState(GameState? _gameState) {}

  @override
  int get gameId => _serverConnection?.gameId ?? -1;

  @override
  bool get isStackOwner => _serverConnection?.isStackOwner ?? false;

  @override
  bool get hasGameStream => _serverConnection?.hasGameStream ?? false;

  @override
  bool get hasLobbyStream => _serverConnection?.hasLobbyStream ?? false;

  @override
  bool get hasUserStatusStream =>
      _serverConnection?.hasUserStatusStream ?? false;

  @override
  bool get hasPlayerStream => _serverConnection?.hasPlayerStream ?? false;

  @override
  bool get hasStackStream => _serverConnection?.hasStackStream ?? false;

  @override
  bool get hasNotificationStream =>
      _serverConnection?.hasNotificationStream ?? false;

  @override
  set gameId(int? _gameId) {
    //Is not allowed to be set from here, but needs to be implemented
  }

  @override
  set isStackOwner(bool? _isStackOwner) {
    //Is not allowed to be set from here, but needs to be implemented
  }
}

final apiProvider = ChangeNotifierProvider<ApiProvider>((ref) {
  return ApiProvider(ref.watch(storageProvider),
      ref.watch(notificationProvider), ref.watch(friendProvider));
});
