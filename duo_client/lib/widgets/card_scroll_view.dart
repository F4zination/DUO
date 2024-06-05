import 'dart:async';

import 'package:duo_client/pb/game.pb.dart';
import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/provider/storage_provider.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:duo_client/widgets/playingcard.dart' as duo;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardScrollView extends ConsumerStatefulWidget {
  const CardScrollView({super.key});

  final Duration _waitDuration = const Duration(milliseconds: 100);

  @override
  ConsumerState<CardScrollView> createState() => _CardScrollViewState();
}

class _CardScrollViewState extends ConsumerState<CardScrollView> {
  bool isTurn = true;
  List<duo.PlayingCard> cards = [];

  //ToDo: BUG if the cards are removed before the animation is done it will crash or before on Reorder is done

  @override
  Widget build(BuildContext context) {
    final _apiProvider = ref.watch(apiProvider);
    final _storageProvider = ref.watch(storageProvider);
    cards = _apiProvider.playerState == null
        ? [
            //TODO delete
            const duo.PlayingCard.fromCard(cardName: 'green_3'),
            const duo.PlayingCard.fromCard(cardName: 'purple_4'),
            const duo.PlayingCard.fromCard(cardName: 'yellow_draw_2'),
            const duo.PlayingCard.fromCard(cardName: 'red_1'),
          ]
        : _apiProvider.playerState!.hand
            .map<duo.PlayingCard>((e) => duo.PlayingCard.fromCard(cardName: e))
            .toList();
    isTurn = _apiProvider.gameState == null
        ? false
        : _apiProvider.gameState!.currentPlayerUuid == _storageProvider.userId;
    return Padding(
      padding: const EdgeInsets.only(bottom: Constants.defaultPadding, top: 70),
      child: ReorderableListView.builder(
        onReorderStart: (index) => {
          HapticFeedback.lightImpact(),
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final card = cards.removeAt(oldIndex);
            cards.insert(newIndex, card);
          });
        },
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            key: UniqueKey(),
            onTap: () {
              setState(() {
                debugPrint('Removing card with value ${cards[index].cardName}');
                playCard(index);
                cards.removeAt(index);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: cards[index],
            ),
          );
        },
      ),
    );
  }

  void playCard(int index) {
    ref.read(apiProvider).streamPlayerAction(PlayerAction(
          action: PlayerAction_ActionType.PLACE,
          cardId: cards[index].cardName,
        ));
  }
}
