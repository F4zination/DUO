import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/game_stacks.dart';
import 'package:duo_client/widgets/playingcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:duo_client/widgets/card_scroll_view.dart';
import 'package:duo_client/widgets/duo_card_stack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});
  static const route = '/game';

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  bool isStack = true;
  bool isLoading = false;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitChasingDots(
                  color: Constants.secondaryColor,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Creating Game...',
                  style: TextStyle(fontSize: 20, color: Colors.white70),
                ),
              ],
            )
          : Stack(children: [
              Container(
                color: Constants.bgColor,
                child: isStack ? const GameStacks() : const CardScrollView(),
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
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ]),
    );
  }
}
