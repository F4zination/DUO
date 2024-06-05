import 'package:duo_client/pb/friend.pb.dart';
import 'package:duo_client/pb/game.pb.dart';
import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/game_stacks.dart';
import 'package:duo_client/widgets/pause_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:duo_client/widgets/card_scroll_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  static const String route = '/game';

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    Future.delayed(Duration.zero, () async {
      String token = await ref.read(apiProvider).getToken();
      debugPrint('Getting game state stream');
      ref.read(apiProvider).sendUserstatusUpdate(token, FriendState.inGame);
      if (ref.read(apiProvider).isStackOwner) {
        debugPrint('Getting stack stream');
        await ref
            .read(apiProvider)
            .getStackStream(token, ref.read(apiProvider).gameId);
        debugPrint('Requesting card for player');
        ref.read(apiProvider).stackInit(token, ref.read(apiProvider).gameId);
      } else {
        debugPrint('Getting player stream');
        ref
            .read(apiProvider)
            .getGameStateStream(token, ref.read(apiProvider).gameId);
        await ref
            .read(apiProvider)
            .getPlayerStream(token, ref.read(apiProvider).gameId);
        debugPrint('Sending player init action');
        ref.read(apiProvider).streamPlayerAction(PlayerAction(
              action: PlayerAction_ActionType.INIT,
              cardId: '',
              token: token,
            ));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('Disposing game_screen');
    closeAllStreams();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isStack = ref.read(apiProvider).isStackOwner;
    return Scaffold(
      body: Stack(children: [
        // Main game screen either card scroll view or game stacks
        Container(
          color: Constants.bgColor,
          child: isStack ? const GameStacks() : const CardScrollView(),
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
                builder: (context) => PauseDialog(
                  onExit: () {
                    closeAllStreams();
                  },
                ),
              );
            },
          ),
        ),
      ]),
    );
  }

  void closeAllStreams() {
    if (ref.read(apiProvider).isStackOwner) {
      ref.read(apiProvider).closeStackStream();
    } else {
      ref.read(apiProvider).closePlayerStream();
      ref.read(apiProvider).closeGameStream();
    }
  }
}
