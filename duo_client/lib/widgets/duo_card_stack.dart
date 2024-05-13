import 'dart:math';

import 'package:flutter/material.dart';
import 'package:duo_client/widgets/playingcard.dart' as duo;

class DUOCardStack extends StatefulWidget {
  const DUOCardStack({super.key, required this.cards, this.isOrdered = false});

  final List<duo.PlayingCard> cards;
  final bool isOrdered;

  @override
  State<DUOCardStack> createState() => _DUOCardStackState();
}

class _DUOCardStackState extends State<DUOCardStack> {
  double randomOffset() {
    return Random().nextDouble() * 10 * (Random().nextBool() ? 1 : -1);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Stack(
        children: [
          for (int i = 0; i < widget.cards.length; i++)
            Positioned(
              left: randomOffset(),
              child: Transform.rotate(
                angle: widget.isOrdered ? 0 : randomOffset() * 0.05,
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: widget.cards[i]),
              ),
            ),
        ],
      ),
    );
  }
}
