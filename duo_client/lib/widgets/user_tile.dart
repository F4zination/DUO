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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    String message = isStack
                        ? 'This device will be used as the Stack and therefore will not be able to participate'
                        : 'This is a normal player device and will be able to participate in the game';
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Info',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary)),
                              content: Text(message,
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
                            ));
                  },
                  icon: SvgPicture.asset(
                    isStack ? 'res/icons/stack.svg' : 'res/icons/user.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
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
        ),
      ),
    );
  }
}
