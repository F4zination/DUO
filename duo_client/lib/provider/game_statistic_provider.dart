import 'package:duo_client/extensions/date_time_extension.dart';
import 'package:duo_client/pb/game_statistic.pb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameStatisticProvider extends ChangeNotifier {
  final List<GameStatistic> _gameStatistics = [
    GameStatistic(
      gameTitle: 'UNO',
      playedAt: DateTime.now().toTimestamp(),
      playerBoard: [
        PlayerBoardItem(rank: 1, name: 'Player1'),
        PlayerBoardItem(rank: 2, name: 'Player2'),
        PlayerBoardItem(rank: 3, name: 'Player3'),
      ],
      scoreBilance: 100,
    ),
    GameStatistic(
      gameTitle: '21 Blitz',
      playedAt: DateTime.now().toTimestamp(),
      playerBoard: [
        PlayerBoardItem(rank: 2, name: 'Player1'),
        PlayerBoardItem(rank: 1, name: 'Player2'),
        PlayerBoardItem(rank: 3, name: 'Player3'),
      ],
      scoreBilance: -50,
    ),
    GameStatistic(
      gameTitle: 'Schafkopf',
      playedAt: DateTime.now().toTimestamp(),
      playerBoard: [
        PlayerBoardItem(rank: 3, name: 'Player1'),
        PlayerBoardItem(rank: 1, name: 'Player2'),
        PlayerBoardItem(rank: 2, name: 'Player3'),
      ],
      scoreBilance: -50,
    ),
    GameStatistic(
      playedAt: DateTime.now().toTimestamp(),
      scoreBilance: -50,
      playerBoard: [
        PlayerBoardItem(rank: 5, name: 'Player1'),
        PlayerBoardItem(rank: 2, name: 'Player2'),
        PlayerBoardItem(rank: 3, name: 'Player3'),
        PlayerBoardItem(rank: 1, name: 'Player4'),
        PlayerBoardItem(rank: 4, name: 'Player5'),
      ],
      gameTitle: 'Skat',
    )
  ];
  GameStatisticProvider();

  List<GameStatistic> get gameStatistics => _gameStatistics;
}

final gameStatisticProvider =
    ChangeNotifierProvider((ref) => GameStatisticProvider());
