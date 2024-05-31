import 'package:duo_client/utils/constants.dart';
import 'package:flutter/material.dart';

class Helpers {
  static Widget getCircleAvatar({
    double radius = 25,
    String? displayedText,
    double fontSize = 16,
    required String text,
  }) {
    displayedText ??= text;
    int hash = text.hashCode;
    int red = hash & 0xFF;
    int green = (hash & 0xFF00) >> 8;
    // int blue = (hash & 0xFF0000) >> 16;
    Color bgColor =
        Color.fromARGB(255, red * 2, green ~/ 5, (red * 2.5).toInt());
    String letter = displayedText[0].toUpperCase();
    return CircleAvatar(
      radius: radius,
      backgroundColor: bgColor.withOpacity(0.5),
      child: Text(
        letter,
        style: TextStyle(
            fontSize: fontSize,
            color: bgColor.computeLuminance() > 0.5
                ? Colors.grey[200]
                : Colors.white70),
      ),
    );
  }

  static String fillPrefixWithZeros(int number) {
    String numberString = number.toString();
    for (int i = 0;
        i < Constants.lengthJoinCode - number.toString().length;
        i++) {
      numberString = '0$numberString';
    }
    debugPrint('Number: $numberString');
    return numberString;
  }

  static String fillPrefixWithZerosForString(String number) {
    for (int i = 0; i < Constants.lengthJoinCode - number.length; i++) {
      number = '0$number';
    }
    debugPrint('Number: $number');
    return number;
  }

  static Widget getTopThreeCircleAvatar(BuildContext context, int index) {
    assert(index > 0 && index < 4, 'Index must be between 1 and 3');
    return CircleAvatar(
      radius: 30,
      backgroundColor: switch (index) {
        1 => Constants.goldColor,
        2 => Constants.silverColor,
        3 => Constants.bronzeColor,
        _ => Colors.white,
      },
      child: Text(
        switch (index) { 1 => '🥇', 2 => '🥈', 3 => '🥉', _ => '-1' },
        style: TextStyle(
          fontSize: 24,
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
        ),
      ),
    );
  }
}
