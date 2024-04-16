//The order of these items is important
enum FriendState {
  offline,
  inGame,
  inLobby,
  online,
}

class Friend {
  final String uuid;
  final String name;
  final int score;
  final FriendState state;

  const Friend({
    required this.uuid,
    required this.name,
    required this.score,
    this.state = FriendState.offline,
  });
}
