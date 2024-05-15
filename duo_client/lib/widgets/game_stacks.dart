import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/widgets/duo_card_stack.dart';
import 'package:duo_client/widgets/playingcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameStacks extends ConsumerStatefulWidget {
  const GameStacks({super.key});

  @override
  ConsumerState<GameStacks> createState() => _GameStacksState();
}

class _GameStacksState extends ConsumerState<GameStacks> {
  @override
  Widget build(BuildContext context) {
    ApiProvider _apiProvider = ref.watch(apiProvider);
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Draw stack
        DUOCardStack(
          cards: [
            PlayingCard(
              cardName: 'red_1',
              isFaceUp: false,
            ),
          ],
          randomAngles: false,
        ),
        // Place stack
        DUOCardStack(
          cards: [
            PlayingCard(
              cardName: 'red_1',
              isFaceUp: true,
            ),
            PlayingCard(
              cardName: 'red_2',
              isFaceUp: true,
            ),
            PlayingCard(
              cardName: 'purple_2',
              isFaceUp: true,
            ),
            PlayingCard(
              cardName: 'draw_4',
              isFaceUp: true,
            ),
            PlayingCard(
              cardName: 'yellow_draw_2',
              isFaceUp: true,
            )
          ],
          randomAngles: true,
        ),
      ],
    );
  }
}
