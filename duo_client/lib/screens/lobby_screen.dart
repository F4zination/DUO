import 'dart:math';
import 'package:animated_background/animated_background.dart';
import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/provider/storage_provider.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/add_tile.dart';
import 'package:duo_client/widgets/invite_dialog.dart';
import 'package:flutter/material.dart';
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
  bool creatingLobby = true;
  final int inviteCode = Random().nextInt(999999);
  late final ApiProvider _apiProvider;
  late final StorageProvider _storageProvider;

  void createLobby() async {
    _apiProvider = ref.watch(apiProvider);
    _storageProvider = ref.watch(storageProvider);
    _apiProvider
        .createSession(_storageProvider.accessToken, inviteCode.toString())
        .then(
      (value) {
        setState(() {
          creatingLobby = false;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      createLobby();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  'Creating Lobby...',
                  style: TextStyle(fontSize: 20, color: Colors.white70),
                )
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AddTile(
                              Dialog: InviteDialog(
                                invideCode: inviteCode,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AddTile(
                              Dialog: InviteDialog(
                                invideCode: inviteCode,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AddTile(
                              Dialog: InviteDialog(
                                invideCode: inviteCode,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AddTile(
                              Dialog: InviteDialog(
                                invideCode: inviteCode,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AddTile(
                              Dialog: InviteDialog(
                                invideCode: inviteCode,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AddTile(
                              Dialog: InviteDialog(
                                invideCode: inviteCode,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.all(Constants.defaultPadding),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Constants.errorColor),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Leave Lobby',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white70)),
                              )),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.all(Constants.defaultPadding),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Constants.successColor),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
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
}
