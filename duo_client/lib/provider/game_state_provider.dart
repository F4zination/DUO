import 'package:duo_client/widgets/playingcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameStateProvider extends ChangeNotifier {
  GameStateProvider();

  List<PlayingCard> _drawPile = [];
  List<PlayingCard> _discardPile = [];
  List<PlayingCard> playersCards = const [
    PlayingCard(cardName: 'red_1', isFaceUp: true),
    PlayingCard(cardName: 'green_2', isFaceUp: true),
    PlayingCard(cardName: 'purple_3', isFaceUp: true),
    PlayingCard(cardName: 'red_change_directions', isFaceUp: true),
    PlayingCard(cardName: 'yellow_4', isFaceUp: true),
    PlayingCard(cardName: 'purple_5', isFaceUp: true),
    PlayingCard(cardName: 'draw_4', isFaceUp: true),
    PlayingCard(cardName: 'red_6', isFaceUp: true),
    PlayingCard(cardName: 'green_7', isFaceUp: true),
  ];

  int disconnect() {
    _drawPile.clear();
    _discardPile.clear();
    notifyListeners();
    return 0;
  }

  PlayingCard get nextDrawCard {
    if (_drawPile.isEmpty) {
      return const PlayingCard(isFaceUp: false, cardName: '-1');
    }
    return _drawPile.first;
  }

  void addCardToDiscardPile(PlayingCard card) {
    _discardPile.add(card);
    notifyListeners();
  }

  void removeCard(int index) {
    playersCards.removeAt(index);
    notifyListeners();
  }
}

final gameStateProvider = ChangeNotifierProvider<GameStateProvider>((ref) {
  return GameStateProvider();
});
