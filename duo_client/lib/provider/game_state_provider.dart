import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameStateProvider extends ChangeNotifier {
  GameStateProvider();
}

final gameStateProvider = ChangeNotifierProvider<GameStateProvider>((ref) {
  return GameStateProvider();
});
