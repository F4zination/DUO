import 'package:duo_client/pb/user.pb.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/duo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.user,
    this.isStack = false,
  });

  final User user;
  final bool isStack;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(
        'UserTile: width: $width, height: $height, isStack: $isStack, user: $user');
    return DuoContainer(
      width: width / 3.5,
      height: height / 4.5,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Constants.defaultRadius),
          child: Padding(
            padding: const EdgeInsets.all(Constants.defaultPadding),
            child: Stack(
              children: [
                isStack
                    ? Positioned(
                        top: -10,
                        right: -5,
                        child: IconButton(
                          style: ButtonStyle(
                              iconColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.onPrimary,
                          )),
                          icon: SvgPicture.asset(
                            'res/icons/stack.svg',
                            colorFilter: const ColorFilter.mode(
                              Constants.successColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Info: Card Stack',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary)),
                                    content: Text(
                                        'The device with this symbol will be used as the Stack and therfore will not be able to play cards',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary)),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  );
                                });
                          },
                        ))
                    : Container(),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      SvgPicture.asset(
                        'res/icons/user.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onPrimary,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user.name,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
