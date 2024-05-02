import 'package:duo_client/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:duo_client/widgets/playingcard.dart' as duo;

class CardScrollView extends StatefulWidget {
  CardScrollView({super.key, required this.cards});

  List<duo.PlayingCard> cards;

  @override
  State<CardScrollView> createState() => _CardScrollViewState();
}

class _CardScrollViewState extends State<CardScrollView> {
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
                widget.cards.removeAt(index);
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
