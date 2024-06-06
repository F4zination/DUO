import 'package:duo_client/pb/game.pb.dart';
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
    StackState stackState = StackState(
      drawStack: DrawStackState(
          cardIds: ref.watch(apiProvider).stackState?.drawStack.cardIds ??
              ['green_1']),
      placeStack: PlaceStackState(
          cardIdOnTop:
              ref.watch(apiProvider).stackState?.placeStack.cardIdOnTop ??
                  'back'),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Draw stack
          SizedBox(
            height: 300,
            child: DUOCardStack(
              cards: [
                PlayingCard(
                  cardName: stackState.drawStack.cardIds.first,
                  isFaceUp: false,
                ),
              ],
              randomAngles: false,
              onTap: (PlayingCard card) async {
                debugPrint('requesting Card for player');
                String token = await ref.read(apiProvider).getToken();
                ref
                    .watch(apiProvider)
                    .requestCard(token, ref.read(apiProvider).gameId);
              },
            ),
          ),
          // Place stack
          SizedBox(
            height: 300,
            child: DUOCardStack(
              cards: [
                PlayingCard(
                  cardName: stackState.placeStack.cardIdOnTop,
                  isFaceUp: true,
                ),
              ],
              randomAngles: true,
            ),
          ),
        ],
      ),
    );
  }
}
