import 'package:duo_client/utils/game/player.dart';
import 'package:duo_client/utils/game/ellipse_distributor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});
  static const route = '/game';

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  List<Player> otherPlayers = [
    Player(playerName: 'Player 1', amountCards: 7, isCurrentPlayer: false),
    Player(playerName: 'Player 2', amountCards: 7, isCurrentPlayer: false),
    Player(playerName: 'Player 3', amountCards: 7, isCurrentPlayer: true),
    Player(playerName: 'Player 4', amountCards: 7, isCurrentPlayer: false),
    Player(playerName: 'Player 5', amountCards: 7, isCurrentPlayer: false),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/game/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 9),
              child: Stack(
                children: [
                  EllipseWidgetDistributor(
                    radiusX: width / 2.8,
                    radiusY: height / 2.5,
                    children: otherPlayers,
                  ),
                  Positioned(
                    left: width / 2.8 - 80,
                    top: height * 0.3,
                    child: Image.asset('assets/game/card_back.png', width: 100),
                  ),
                  Positioned(
                    right: width / 2.8 - 80,
                    top: height * 0.3,
                    child: Image.asset("assets/game/uno_cards/red_1.png",
                        width: 100),
                  ),
                ],
              ))),
    );
  }
}
