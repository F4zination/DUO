import 'package:duo_client/provider/game_state_provider.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:duo_client/widgets/playingcard.dart' as duo;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardScrollView extends ConsumerStatefulWidget {
  CardScrollView({super.key, required this.cards});

  List<duo.PlayingCard> cards;

  @override
  ConsumerState<CardScrollView> createState() => _CardScrollViewState();
}

class _CardScrollViewState extends ConsumerState<CardScrollView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Constants.defaultPadding, top: 70),
      child: ReorderableListView.builder(
        onReorder: (oldIndex, newIndex) => setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final card = widget.cards.removeAt(oldIndex);
          widget.cards.insert(newIndex, card);
        }),
        scrollDirection: Axis.horizontal,
        itemCount: widget.cards.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(widget.cards[index].cardName),
            direction: DismissDirection.up,
            onDismissed: (direction) {
              setState(() {
                print(
                    'Removing card with value ${widget.cards[index].cardName}');

                ref.read(gameStateProvider).removeCard(index);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.cards[index],
            ),
          );
        },
      ),
    );
  }
}
