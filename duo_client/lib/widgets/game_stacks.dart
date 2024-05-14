import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/widgets/duo_card_stack.dart';
import 'package:duo_client/widgets/playingcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameStacks extends ConsumerWidget {
  const GameStacks({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DUOCardStack(
            cards: ref
                .watch(apiProvider)
                .stackState!
                .drawStack
                .cards
                .getRange(0, 8)
                .map(
                  (card) => PlayingCard(
                    cardName: card.cardId,
                    isFaceUp: false,
                  ),
                )
                .toList(),
            randomAngles: false),
        DUOCardStack(
          cards: ref
              .watch(apiProvider)
              .stackState!
              .placeStack
              .cardOnTop
              .map((e) => PlayingCard(
                    cardName: e.cardId,
                    isFaceUp: true,
                  ))
              .toList(),
          randomAngles: true,
        ),
      ],
    );
  }
}
