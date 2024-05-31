class PlayedGame {
  final int id;
  final String gameType;
  final int amountofPlayers;
  final int score;
  final Duration duration;
  final DateTime date;
  final int placement;

  PlayedGame({
    required this.id,
    required this.gameType,
    required this.amountofPlayers,
    required this.score,
    required this.duration,
    required this.date,
    required this.placement,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gameType': gameType,
      'amoutOfPlayers': amountofPlayers,
      'score': score,
      'duration': duration.inSeconds,
      'date': date.toIso8601String(),
      'placement': placement,
    };
  }

  factory PlayedGame.fromMap(Map<String, dynamic> map) {
    return PlayedGame(
      id: map['id'],
      gameType: map['gameType'],
      amountofPlayers: map['amoutOfPlayers'],
      score: map['score'],
      duration: Duration(seconds: map['duration']),
      date: DateTime.parse(map['date']),
      placement: map['placement'],
    );
  }
}
