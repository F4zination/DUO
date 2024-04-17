import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/duo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameDialog extends StatelessWidget {
  const GameDialog({super.key});

  @override
  Widget build(context) {
    return Dialog(
      backgroundColor: Constants.secondaryColorDark,
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
          width: 400,
          height: 250,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text('NEW GAME',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Constants.primaryColor)),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DuoContainer(
                      width: 150,
                      backgroundColor: Constants.primaryColor,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius:
                              BorderRadius.circular(Constants.defaultRadius),
                          onTap: () {
                            debugPrint('Host Game has been pressed');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('res/icons/wifi_house.svg',
                                  width: 100),
                              const SizedBox(height: 10),
                              const Text('Host Game',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DuoContainer(
                      width: 150,
                      backgroundColor: Constants.primaryColorAccent,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius:
                              BorderRadius.circular(Constants.defaultRadius),
                          onTap: () {
                            debugPrint('Join Game has been pressed');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  'res/icons/gaming_controller.svg',
                                  width: 100),
                              const SizedBox(height: 10),
                              const Text('Join Game',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
