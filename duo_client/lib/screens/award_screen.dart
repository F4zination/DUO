import 'package:flutter/material.dart';

class AwardScreen extends StatefulWidget {
  const AwardScreen({super.key});

  static const String route = '/award';

  @override
  State<AwardScreen> createState() => _AwardScreenState();
}

class _AwardScreenState extends State<AwardScreen> {
  @override
  void initState() {
    super.initState();
    // save the game to the database^
    // ref.read(playedGamesProvider).addGame(game);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
