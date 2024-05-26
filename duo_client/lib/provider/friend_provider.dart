import 'package:duo_client/pb/friend.pb.dart';
import 'package:duo_client/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendProvider extends ChangeNotifier {
  final ApiProvider _apiProvider;

  final List<Friend> _friends = [
    // Friend(
    //   uuid: '1',
    //   name: 'Joe Mama',
    //   score: 300,
    // ),
    // Friend(
    //   uuid: '2',
    //   name: 'ZinsiBinsi',
    //   state: FriendState.inGame,
    //   score: 150,
    // ),
    // Friend(
    //   uuid: '3',
    //   name: 'Rehnertli',
    //   state: FriendState.inLobby,
    //   score: 200,
    // ),
    // Friend(
    //   uuid: '4',
    //   name: 'Hillibilli',
    //   state: FriendState.online,
    //   score: 100,
    // ),
  ];

  FriendProvider(ApiProvider apiProvider) : _apiProvider = apiProvider;

  List<Friend> get friends => _friends;

  void addFriend(Friend friend) {
    _friends.add(friend);
    notifyListeners();
  }

  void removeFriend(Friend friend) {
    _friends.remove(friend);
    notifyListeners();
  }
}

final friendProvider =
    ChangeNotifierProvider((ref) => FriendProvider(ref.watch(apiProvider)));
