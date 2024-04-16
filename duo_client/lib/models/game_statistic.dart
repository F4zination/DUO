class GameStatistic {
  final DateTime played;
  final int scoreBilance; // score added or subtracted
  final Map<int, String> playersBoard; // player's place and name
  final String gameTitle;
  final int ownPlace; // player's place for easier access

  const GameStatistic({
    required this.played,
    required this.scoreBilance,
    required this.playersBoard,
    required this.gameTitle,
    required this.ownPlace,
  });
}
