import 'package:animated_background/animated_background.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/add_tile.dart';
import 'package:duo_client/widgets/invite_dialog.dart';
import 'package:flutter/material.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});

  static const route = "/lobby";

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen>
    with TickerProviderStateMixin {
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
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )),
        ),
      ),
      body: AnimatedBackground(
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
                  'Players',
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
                          Dialog: InviteDialog(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AddTile(
                          Dialog: InviteDialog(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AddTile(
                          Dialog: InviteDialog(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AddTile(
                          Dialog: InviteDialog(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AddTile(
                          Dialog: InviteDialog(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AddTile(
                          Dialog: InviteDialog(),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Constants.defaultPadding),
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
                      padding: const EdgeInsets.all(Constants.defaultPadding),
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
