import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  const Player(
      {super.key,
      required this.playerName,
      required this.amountCards,
      required this.isCurrentPlayer});

  final String playerName;
  final int amountCards;
  final bool isCurrentPlayer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: isCurrentPlayer ? Colors.green : Colors.grey,
          blurRadius: 50,
          spreadRadius: 2,
        ),
      ]),
      child: Card(
        color: Colors.black.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 80,
            child: Column(children: [
              Icon(Icons.person,
                  color: isCurrentPlayer ? Colors.green : Colors.grey),
              Text(playerName, style: const TextStyle(color: Colors.white)),
              Text(
                'Cards: $amountCards',
                style: const TextStyle(color: Colors.white),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
