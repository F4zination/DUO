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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //init the stack stream
      String token = await ref.read(apiProvider).getToken();
      ref.read(apiProvider).getStackStream(token, ref.read(apiProvider).gameId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiProvider _apiProvider = ref.watch(apiProvider);
    StackState stackState = _apiProvider.stackState ??
        StackState(
          drawStack: DrawStackState(
              cardIds:
                  _apiProvider.stackState?.drawStack.cardIds ?? ['green_1']),
          placeStack: PlaceStackState(
              cardIdOnTop:
                  _apiProvider.stackState?.placeStack.cardIdOnTop ?? 'green_1'),
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
