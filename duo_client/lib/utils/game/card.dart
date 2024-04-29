import 'package:flutter/material.dart';

class PlayingCard extends StatelessWidget {
  const PlayingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        scale: 0.5,
        "assets/game/Kartendeck.png",
      ),
    );
  }
}
