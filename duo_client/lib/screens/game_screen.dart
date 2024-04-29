import 'package:duo_client/provider/game_state_provider.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:duo_client/utils/game/card.dart' as duo;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              int status = ref.watch(gameStateProvider).disconnect();
              if (status != 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to disconnect'),
                  ),
                );
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Container(
        color: Constants.bgColor,
        child: const Padding(
          padding: EdgeInsets.all(Constants.defaultPadding),
          child: Row(
            children: [
              duo.PlayingCard(),
              SizedBox(width: Constants.defaultPadding),
              duo.PlayingCard(),
              SizedBox(width: Constants.defaultPadding),
              duo.PlayingCard(),
            ],
          ),
        ),
      ),
    );
  }
}
