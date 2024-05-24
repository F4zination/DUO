import 'dart:math';

import 'package:animated_background/animated_background.dart';
import 'package:duo_client/pb/user.pb.dart';
import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/provider/storage_provider.dart';
import 'package:duo_client/screens/game_screen.dart';
import 'package:duo_client/screens/home_screen.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/utils/helpers.dart';
import 'package:duo_client/widgets/add_tile.dart';
import 'package:duo_client/widgets/invite_dialog.dart';
import 'package:duo_client/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LobbyScreen extends ConsumerStatefulWidget {
  const LobbyScreen({super.key});

  static const route = "/lobby";

  @override
  ConsumerState<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends ConsumerState<LobbyScreen>
    with TickerProviderStateMixin {
  bool joiningGame = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    ApiProvider _apiProvider = ref.watch(apiProvider);
    bool creatingLobby =
        _apiProvider.lobbyStatus == null && _apiProvider.gameId == -1;
    int lobbyId = _apiProvider.lobbyStatus?.lobbyId ?? 0;
    if (_apiProvider.gameId != -1) {
      setState(() {
        joiningGame = true;
        debugPrint('Game Id: ${_apiProvider.gameId}');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(GameScreen.route);
        });
      });
    }
    if (!_apiProvider.hasLobbyStream && _apiProvider.gameId == null) {
      setState(() {
        debugPrint('Lobby Stream: ${_apiProvider.lobbyStatus?.lobbyId}');
        //Case if lobby is deleted by the Host
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pop();
        });
      });
    }

    return Scaffold(
      backgroundColor: Constants.bgColor,
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.all(18.0),
          child: Center(
              child: Text(
            'Lobby',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          )),
        ),
      ),
      body: creatingLobby
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpinKitChasingDots(
                  color: Constants.secondaryColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  joiningGame ? 'Joining Game...' : 'Joining Lobby...',
                  style: const TextStyle(fontSize: 20, color: Colors.white70),
                ),
                const SizedBox(
                  height: 20,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.exit_to_app_outlined,
                      color: Colors.white,
                    )),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )
          : AnimatedBackground(
              behaviour: RandomParticleBehaviour(
                options: const ParticleOptions(
                  baseColor: Constants.primaryColor,
                  spawnMaxSpeed: 100,
                  spawnMinSpeed: 50,
                  spawnMaxRadius: 10,
                  spawnMinRadius: 5,
                  particleCount: 100,
                ),
              ),
              vsync: this,
              child: Padding(
                padding: const EdgeInsets.all(Constants.defaultPadding),
                child: Column(
                  children: [
                    const Text(
                      'DUO PLAYERS',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.5,
                        ),
                        children: [
                          ...(ref.watch(apiProvider).lobbyStatus?.users ?? [])
                              .map((user) {
                            // TODO: the user.isStack is not working but is in Database correctly
                            return Padding(
                              padding: const EdgeInsets.all(
                                  Constants.defaultPadding / 2),
                              child: ref
                                          .watch(apiProvider)
                                          .lobbyStatus!
                                          .users
                                          .where((element) => element.isStack)
                                          .first
                                          .uuid ==
                                      user.uuid
                                  ? UserTile(user: user, isStack: true)
                                  : UserTile(user: user, isStack: false),
                            );
                          }),
                          ...List.generate(
                              (ref.watch(apiProvider).lobbyStatus?.maxPlayers ??
                                      8) -
                                  (ref.watch(apiProvider).lobbyStatus?.users ??
                                          [])
                                      .length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(
                                  Constants.defaultPadding / 2),
                              child: AddTile(
                                Dialog: InviteDialog(
                                  invideCode:
                                      Helpers.fillPrefixWithZeros(lobbyId),
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Constants.errorColor),
                              onPressed: () async {
                                int status = await ref
                                    .read(apiProvider)
                                    .disconnectLobby(
                                        ref.read(storageProvider).accessToken,
                                        ref
                                                .watch(apiProvider)
                                                .lobbyStatus
                                                ?.lobbyId ??
                                            0);
                                if (status == 0) {
                                  print('Disconnected sucessfully from lobby');
                                  Navigator.of(context)
                                      .pushReplacementNamed(HomeScreen.route);
                                } else {
                                  print('Error leaving lobby');
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(3),
                                child: Text('Leave Lobby',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white70)),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Constants.successColor),
                              onPressed: () async {
                                if (ref.read(storageProvider).userId ==
                                    ref
                                        .read(apiProvider)
                                        .lobbyStatus!
                                        .users
                                        .where((element) => element.isAdmin)
                                        .first
                                        .uuid) {
                                  // TODO: change back to 3 players for a game but for testing purposes 2
                                  if (_apiProvider.lobbyStatus!.users.length <
                                      2) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'You need at least 3 players to start the game'),
                                      ),
                                    );
                                    return;
                                  }
                                  String token =
                                      await ref.read(apiProvider).getToken();
                                  ref.read(apiProvider).startGame(token);
                                  joiningGame = true;
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Only the Host can start the game'),
                                    ),
                                  );
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text('Start Game',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white70)),
                              )),
                        )
                      ],
                    )
                  ],
                ),
              )),
    );
  }

  User getStackUser(List<User> users) {
    for (User user in users) {
      if (user.isStack) {
        return user;
      }
    }
    return User();
  }
}
