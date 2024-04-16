import 'package:duo_client/models/game_statistic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameStatisticProvider extends ChangeNotifier {
  final List<GameStatistic> _gameStatistics = [
    GameStatistic(
      gameTitle: 'UNO',
      ownPlace: 1,
      played: DateTime.now(),
      playersBoard: {4: 'Player1', 2: 'Player2', 3: 'Player3'},
      scoreBilance: 100,
    ),
    GameStatistic(
      gameTitle: '21 Blitz',
      ownPlace: 2,
      played: DateTime.now(),
      playersBoard: {4: 'Player1', 2: 'Player2', 3: 'Player3'},
      scoreBilance: -50,
    ),
    GameStatistic(
      gameTitle: 'Schafkopf',
      ownPlace: 3,
      played: DateTime.now(),
      playersBoard: {4: 'Player1', 2: 'Player2', 3: 'Player3'},
      scoreBilance: -50,
    ),
    GameStatistic(
        played: DateTime.now(),
        scoreBilance: -50,
        playersBoard: {4: 'Player1', 2: 'Player2', 3: 'Player3'},
        gameTitle: 'Skat',
        ownPlace: 8)
  ];
  GameStatisticProvider();

  List<GameStatistic> get gameStatistics => _gameStatistics;
}

final gameStatisticProvider =
    ChangeNotifierProvider((ref) => GameStatisticProvider());
