import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/provider/game_state_provider.dart';
import 'package:duo_client/provider/storage_provider.dart';
import 'package:duo_client/screens/home_screen.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/game_stacks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:duo_client/widgets/playingcard.dart' as duo;
import 'package:duo_client/widgets/card_scroll_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});
  static const route = '/game';

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  late bool is_turn;
  late bool is_stack;

  @override
  void initState() {
    super.initState();
    is_turn = false;
    is_stack = false;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          color: Constants.bgColor,
          child: is_stack ? const GameStacks() : CardScrollView(),
        ),
        Positioned(
          top: 10,
          right: 20,
          child: IconButton(
            icon: SvgPicture.asset(
              'res/icons/settings.svg',
              colorFilter: const ColorFilter.mode(
                Colors.white70,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              setState(() {
                is_stack = !is_stack;
              });
            },
          ),
        ),
      ]),
    );
  }
}
