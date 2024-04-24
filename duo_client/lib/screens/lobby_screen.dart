import 'package:animated_background/animated_background.dart';
import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/provider/storage_provider.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/utils/helpers.dart';
import 'package:duo_client/widgets/add_tile.dart';
import 'package:duo_client/widgets/invite_dialog.dart';
import 'package:duo_client/widgets/user_tile.dart';
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
  late final ApiProvider _apiProvider;
  int lobbyID = -1;
  String displaylobbyID = '';
  late final StorageProvider _storageProvider;

  void createLobby() async {
    try {
      _apiProvider = ref.watch(apiProvider);
      _storageProvider = ref.watch(storageProvider);
      _apiProvider.init(ServerConnectionType.grpc);
      _apiProvider.createLobby(_storageProvider.accessToken).then(
        (value) {
          lobbyID = value;
          displaylobbyID = Helpers.fillPrefixWithZeros(lobbyID);
          setState(() {
            creatingLobby = false;
          });
        },
      );
    } catch (e) {
      print(e);
    }
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
                          ..._apiProvider.lobbyStatus!.users.map((user) {
                            return UserTile(user: user);
                          }),
                          ...List.generate(
                              _apiProvider.lobbyStatus!.maxPlayers -
                                  _apiProvider.lobbyStatus!.users.length,
                              (index) {
                            return AddTile(
                              Dialog: InviteDialog(
                                invideCode: displaylobbyID,
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
                                        lobbyID);
                                if (status == 0) {
                                  Navigator.of(context).pop();
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
                              onPressed: () {
                                Navigator.of(context).pop();
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
}
