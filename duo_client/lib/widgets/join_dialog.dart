import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/duo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JoinDialog extends StatelessWidget {
  const JoinDialog({super.key});

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
              const Text(
                'Enter the invite code to join a game',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.all(Constants.defaultPadding),
                  child: TextField(
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
                onPressed: () {},
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
