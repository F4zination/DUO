import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/provider/storage_provider.dart';
import 'package:duo_client/screens/lobby_screen.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/duo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JoinDialog extends ConsumerStatefulWidget {
  const JoinDialog({Key? key});

  @override
  ConsumerState<JoinDialog> createState() => _JoinDialogState();
}

class _JoinDialogState extends ConsumerState<JoinDialog> {
  TextEditingController _controller = TextEditingController();
  bool wrongInviteCode = false;
  String hintText = 'Enter the invite code to join a game';

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: DuoContainer(
      backgroundColor: Constants.bgColor,
      child: SizedBox(
        width: 400,
        height: 300,
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
                      ))),
              IconButton(
                onPressed: () async {
                  print('Joining session with invite code ${_controller.text}');
                  int stauts = await ref.read(apiProvider).joinSession(
                      ref.read(storageProvider).accessToken,
                      5,
                      _controller.text);
                  if (stauts == 0) {
                    Navigator.of(context)
                        .pushReplacementNamed(LobbyScreen.route);
                  } else {
                    print('Error joining session value $stauts');
                    setState(() {
                      wrongInviteCode = true;
                      hintText = 'Invalid invite code';
                    });
                  }
                },
                icon: SvgPicture.asset(
                  'res/icons/play_button.svg',
                  height: 50,
                  colorFilter: const ColorFilter.mode(
                    Constants.successColor,
                    BlendMode.srcIn,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
