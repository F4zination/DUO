import 'package:duo_client/pb/game_rule.pb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameRuleProvider extends ChangeNotifier {
  final List<GameRule> _gameRules = [
    GameRule(uuid: '1', name: 'Classic'),
    GameRule(uuid: '2', name: 'Duo'),
    GameRule(uuid: '3', name: 'Squad'),
  ];

  List<GameRule> get gameRules => _gameRules;
}

final gameRuleProvider = ChangeNotifierProvider((ref) => GameRuleProvider());
