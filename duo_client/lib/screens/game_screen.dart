import 'dart:math';

import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/provider/storage_provider.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/utils/helpers.dart';
import 'package:duo_client/widgets/game_stacks.dart';
import 'package:duo_client/widgets/pause_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:duo_client/widgets/card_scroll_view.dart';
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
  bool isLoading = false;
  late ApiProvider _apiProvider;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(apiProvider).getGameStateStream(
            ref.read(storageProvider).accessToken,
            _apiProvider.gameId,
          );
    });
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
    // TODO: implement isStack
    bool isStack = true;
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
              // Main game screen either card scroll view or game stacks
              Container(
                color: Constants.bgColor,
                child: isStack
                    ? GameStacks(
                        gameId: _apiProvider.gameId,
                      )
                    : CardScrollView(
                        gameId: _apiProvider.gameId,
                      ),
              ),
              Positioned(
                top: 10,
                right: 20,
                // Settings button
                child: IconButton(
                  icon: SvgPicture.asset(
                    'res/icons/settings.svg',
                    colorFilter: const ColorFilter.mode(
                      Colors.white70,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const PauseDialog(),
                    );
                  },
                ),
              ),
            ]),
    );
  }
}
