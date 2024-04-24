import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/duo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetUserDialog extends StatelessWidget {
  const GetUserDialog({super.key});

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
                'Enter your username',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter your username to join the game',
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
                        hintText: 'Username',
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
                icon: SvgPicture.asset(
                  'res/icons/arrow_right.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
