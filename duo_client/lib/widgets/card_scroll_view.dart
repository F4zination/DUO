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
  bool _isReordering = false;
  bool isTurn = false;
  List<duo.PlayingCard> cards = [];

  //ToDo: BUG if the cards are removed before the animation is done it will crash or before on Reorder is done

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String token = await ref.read(apiProvider).getToken();
      await ref
          .read(apiProvider)
          .getPlayerStream(token, ref.read(apiProvider).gameId);
      ref.read(apiProvider).streamPlayerAction(PlayerAction(
            action: PlayerAction_ActionType.INIT,
            cardId: '',
            token: token,
          ));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _apiProvider = ref.watch(apiProvider);
    final _storageProvider = ref.watch(storageProvider);
    cards = _apiProvider.playerState == null
        ? [
            //TODO delete
            const duo.PlayingCard.fromCard(cardName: 'green_3'),
            const duo.PlayingCard.fromCard(cardName: 'purple_draw_2'),
            const duo.PlayingCard.fromCard(cardName: 'red_change_directions'),
            const duo.PlayingCard.fromCard(cardName: 'yellow_suspend'),
            const duo.PlayingCard.fromCard(cardName: 'draw_4'),
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
            _isReordering = true;
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final card = cards.removeAt(oldIndex);
            cards.insert(newIndex, card);
          });
          Future.delayed(widget._waitDuration, () {
            setState(() {
              _isReordering = false;
            });
          });
        },
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(cards[index].cardName),
            direction: isTurn ? DismissDirection.up : DismissDirection.none,
            onDismissed: (direction) {
              if (!_isReordering) {
                setState(() {
                  _isReordering = true;
                  // ref.read(gameStateProvider).removeCard(index);
                  cards.removeAt(index);
                  playCard(index);
                  print('Removing card with value ${cards[index].cardName}');
                });
              } else {
                print('Reordering in progress');
              }
              Future.delayed(widget._waitDuration, () {
                setState(() {
                  _isReordering = false;
                });
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
