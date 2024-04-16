import 'package:duo_client/models/game_rule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameRuleProvider extends ChangeNotifier {
  final List<GameRule> _gameRules = [
    GameRule(id: '1', name: 'Classic'),
    GameRule(id: '2', name: 'Duo'),
    GameRule(id: '3', name: 'Squad'),
  ];

  List<GameRule> get gameRules => _gameRules;
}

final gameRuleProvider = ChangeNotifierProvider((ref) => GameRuleProvider());
