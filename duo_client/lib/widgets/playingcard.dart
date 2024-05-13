import 'package:flutter/material.dart';

class PlayingCard extends StatelessWidget {
  const PlayingCard({super.key, this.cardName = 'red_1', this.isFaceUp = true});

  const PlayingCard.fromCard(
      {super.key, required this.cardName, this.isFaceUp = true});

  final String cardName;
  final bool isFaceUp;

  @override
  Widget build(BuildContext context) {
    return isFaceUp
        ? ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              scale: 0.5,
              "assets/game/duo_cards/$cardName.png",
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              scale: 0.5,
              "assets/game/duo_cards/back.png",
            ),
          );
  }
}
