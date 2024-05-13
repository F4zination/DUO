import 'package:flutter/material.dart';

class PlayingCard extends StatelessWidget {
  const PlayingCard({super.key, this.cardName = 'red_1'});

  const PlayingCard.fromCard({super.key, required this.cardName});

  final String cardName;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        scale: 0.5,
        "assets/game/duo_cards/$cardName.png",
      ),
    );
  }
}
