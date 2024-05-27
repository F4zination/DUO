import 'package:duo_client/pb/game.pb.dart';
import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/provider/storage_provider.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //init the stack stream
      ref.read(apiProvider).getStackStream(
          ref.read(storageProvider).accessToken, ref.read(apiProvider).gameId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiProvider _apiProvider = ref.watch(apiProvider);
    StackState stackState = _apiProvider.stackState ??
        StackState(
          drawStack: DrawStackState(cardIds: ['green_3']),
          placeStack: PlaceStackState(cardIdOnTop: 'green_3'),
        );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Draw stack
        DUOCardStack(
          cards: [
            PlayingCard(
              cardName: stackState.drawStack.cardIds.first,
              isFaceUp: false,
            ),
          ],
          randomAngles: false,
          onTap: (PlayingCard card) {
            // maybe implement later
          },
        ),
        // Place stack
        DUOCardStack(
          cards: [
            PlayingCard(
              cardName: stackState.placeStack.cardIdOnTop,
              isFaceUp: true,
            ),
          ],
          randomAngles: true,
        ),
      ],
    );
  }
}
