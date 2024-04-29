import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:duo_client/pb/game.pb.dart' as pb;

class GameStateProvider extends ChangeNotifier {
  GameStateProvider();

  List<pb.Card> _drawPile = [];
  List<pb.Card> _discardPile = [];

  int disconnect() {
    _drawPile.clear();
    _discardPile.clear();
    notifyListeners();
    return 0;
  }

  pb.Card get nextDrawCard {
    if (_drawPile.isEmpty) {
      return pb.Card(isFaceUp: false, cardId: '-1');
    }
    return _drawPile.first;
  }

  void addCardToDiscardPile(pb.Card card) {
    _discardPile.add(card);
    notifyListeners();
  }
}

final gameStateProvider = ChangeNotifierProvider<GameStateProvider>((ref) {
  return GameStateProvider();
});
