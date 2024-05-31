import 'package:duo_client/pb/friend.pb.dart';
import 'package:duo_client/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendProvider extends ChangeNotifier {
  ApiProvider? _apiProvider;
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

  FriendProvider();

  List<Friend> get friends => _friends;

  Future<void> fetchFriends() async {
    _friends.clear();
    String token = await _apiProvider!.getToken();
    _friends.addAll(await _apiProvider!.getFriends(token));
    notifyListeners();
  }

  //TODO[adrian] maybe: void deleteFriendRequests(String requesterId) {}

  void addFriend(Friend friend) {
    _friends.add(friend);
    // dont know if this is necessary
    notifyListeners();
  }

  void removeFriend(Friend friend) {
    _friends.remove(friend);
    // dont know if this is possible
    notifyListeners();
  }
}

final friendProvider = ChangeNotifierProvider((ref) => FriendProvider());
