import 'package:flutter/material.dart';

class PlayingCard extends StatelessWidget {
  PlayingCard({super.key});

  PlayingCard.fromCard({super.key, required this.cardName});

  String cardName = 'red_1';

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
