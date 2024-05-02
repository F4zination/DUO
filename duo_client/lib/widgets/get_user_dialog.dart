import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/screens/home_screen.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/duo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetUserDialog extends ConsumerStatefulWidget {
  const GetUserDialog({super.key});

  @override
  ConsumerState<GetUserDialog> createState() => _GetUserDialogState();
}

class _GetUserDialogState extends ConsumerState<GetUserDialog> {
  final TextEditingController _controller = TextEditingController();
  bool wrongUsername = false;
  bool loading = false;
  String hintText = 'Enter your username to join the game';

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
              Text(
                hintText,
                style: TextStyle(
                  fontSize: 16,
                  color: wrongUsername ? Constants.errorColor : Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.all(Constants.defaultPadding),
                  child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        contentPadding: const EdgeInsets.all(15),
                        hintStyle: TextStyle(
                          color: wrongUsername
                              ? Constants.errorColor
                              : Colors.white70,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: wrongUsername
                                ? Constants.errorColor
                                : Colors.white70,
                          ),
                        ),
                        fillColor: wrongUsername
                            ? Constants.errorColor
                            : Colors.white70,
                      ),
                      keyboardType: TextInputType.text,
                      onSubmitted: (value) async {
                        if (_controller.text.isEmpty) {
                          setState(() {
                            wrongUsername = true;
                            hintText = 'Please enter a username to continue';
                          });
                        } else {
                          setState(() {
                            loading = true;
                          });
                          int status = await ref
                              .read(apiProvider)
                              .registerUser(_controller.text);
                          if (status == 0) {
                            Navigator.of(context)
                                .pushReplacementNamed(HomeScreen.route);
                          } else {
                            print('Username not available');
                            setState(() {
                              wrongUsername = true;
                              hintText = 'User not found';
                            });
                          }
                        }
                      },
                      style: const TextStyle(
                        color: Colors.white70,
                      ))),
              const SizedBox(height: 20),
              loading
                  ? const CircularProgressIndicator()
                  : IconButton(
                      icon: SvgPicture.asset(
                        'res/icons/arrow_right.svg',
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                      ),
                      onPressed: () async {
                        if (_controller.text.isEmpty) {
                          setState(() {
                            wrongUsername = true;
                          });
                        } else {
                          setState(() {
                            loading = true;
                          });
                          int status = await ref
                              .read(apiProvider)
                              .registerUser(_controller.text);
                          if (status == 0) {
                            Navigator.of(context)
                                .pushReplacementNamed(HomeScreen.route);
                          } else {
                            print('registerUser returned $status');
                            setState(() {
                              wrongUsername = true;
                              loading = false;
                              hintText = 'User not found';
                            });
                          }
                        }
                      }),
            ],
          ),
        ),
      ),
    ));
  }
}
