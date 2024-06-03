import 'package:duo_client/pb/friend.pb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendProvider extends ChangeNotifier {
  final List<Friend> _friends = [];

  FriendProvider();

  List<Friend> get friends => _friends;

  //TODO[adrian] maybe: void deleteFriendRequests(String requesterId) {}

  void addFriend(Friend friend) {
    _friends.add(friend);
    // dont know if this is necessary
    notifyListeners();
  }

  void setFriends(List<Friend> friends) {
    _friends.clear();
    _friends.addAll(friends);
    notifyListeners();
  }

  void removeFriend(Friend friend) {
    _friends.remove(friend);
    // dont know if this is possible
    notifyListeners();
  }
}

final friendProvider = ChangeNotifierProvider((ref) => FriendProvider());
