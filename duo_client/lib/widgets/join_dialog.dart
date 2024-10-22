import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/provider/storage_provider.dart';
import 'package:duo_client/screens/lobby_screen.dart';
import 'package:duo_client/screens/qr_scanner_screen.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JoinDialog extends ConsumerStatefulWidget {
  const JoinDialog({super.key});

  @override
  ConsumerState<JoinDialog> createState() => _JoinDialogState();
}

class _JoinDialogState extends ConsumerState<JoinDialog> {
  final TextEditingController _controller = TextEditingController();
  bool wrongInviteCode = false;
  String hintText = 'Enter the invite code to join a game';

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.all(20),
        child: SizedBox(
          width: 400,
          height: 285,
          child: Padding(
            padding: const EdgeInsets.all(Constants.defaultPadding),
            child: Column(
              children: [
                const Text(
                  'Join a Game',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ),
                const SizedBox(height: 20),
                Text(
                  hintText,
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        wrongInviteCode ? Constants.errorColor : Colors.white70,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.all(Constants.defaultPadding),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              controller: _controller,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(6),
                              ],
                              decoration: const InputDecoration(
                                hintText: 'Invite Code',
                                contentPadding: EdgeInsets.all(15),
                                hintStyle: TextStyle(
                                  color: Colors.white70,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white70,
                                  ),
                                ),
                                fillColor: Colors.white70,
                              ),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                color: Colors.white70,
                              )),
                        ),
                        const SizedBox(width: Constants.defaultPadding / 2),
                        IconButton(
                            onPressed: () async {
                              //Just here pushNamed and not pushReplacementNamed
                              dynamic id = await Navigator.of(context)
                                  .pushNamed(QrCodeScanner.route);
                              if (id != null) {
                                _controller.text =
                                    Helpers.fillPrefixWithZerosForString(
                                        id.toString());
                                joinGame();
                              }
                            },
                            icon: const Icon(
                              Icons.qr_code_scanner_rounded,
                              color: Colors.white70,
                            ))
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        )),
                    IconButton(
                      onPressed: joinGame,
                      icon: SvgPicture.asset(
                        'res/icons/play_button.svg',
                        height: 50,
                        colorFilter: const ColorFilter.mode(
                          Constants.successColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void joinGame() {
    if (_controller.text.isEmpty) {
      setState(() {
        wrongInviteCode = true;
        hintText = 'Invite code needs to be 6 digits long';
      });
      return;
    }
    if (_controller.text.length < 6) {
      _controller.text = Helpers.fillPrefixWithZerosForString(_controller.text);
    }
    ref
        .read(apiProvider)
        .joinLobby(
            ref.read(storageProvider).accessToken, int.parse(_controller.text))
        .then((value) {
      //TODO: await lobby stream and then connect
      Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.of(context).pushReplacementNamed(LobbyScreen.route);
      });
    }).catchError((error) {
      setState(() {
        wrongInviteCode = true;
        hintText = 'Invite code is invalid';
      });
    });
  }
}
