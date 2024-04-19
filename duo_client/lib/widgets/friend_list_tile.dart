import 'package:duo_client/pb/friend.pb.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/utils/helpers.dart';
import 'package:duo_client/widgets/duo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FriendListTile extends StatelessWidget {
  final Friend friend;
  final VoidCallback? onTap;
  final bool? showIcons;
  const FriendListTile({
    required this.friend,
    this.showIcons,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DuoContainer(
      margin: const EdgeInsets.only(
        right: Constants.defaultPadding,
        left: Constants.defaultPadding,
        bottom: Constants.defaultPadding,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Constants.defaultRadius),
          onTap: onTap ?? () {},
          child: Padding(
            padding: const EdgeInsets.all(Constants.defaultPadding / 2),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Constants.defaultPadding / 2),
                  child: Helpers.getCircleAvatar(text: friend.name),
                ),
                const SizedBox(width: Constants.defaultPadding),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          friend.name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                        const SizedBox(height: Constants.defaultPadding / 4),
                        Text(
                          switch (friend.state) {
                            FriendState.offline => 'Offline',
                            FriendState.inGame => 'in game',
                            FriendState.inLobby => 'in lobby',
                            FriendState.online => 'Online',
                            _ => 'Unknown',
                          },
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: switch (friend.state) {
                                  FriendState.offline => Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(0.30),
                                  FriendState.inGame => Constants.warningColor,
                                  FriendState.inLobby => Constants.warningColor,
                                  FriendState.online => Constants.successColor,
                                  _ => Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(0.30),
                                },
                              ),
                        ),
                      ]),
                ),
                showIcons ?? true
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: 'Invite to game',
                            icon: SvgPicture.asset(
                              'res/icons/mail.svg',
                              colorFilter: const ColorFilter.mode(
                                  Colors.white54, BlendMode.srcIn),
                            ),
                            onPressed: () {},
                          ),
                          const SizedBox(width: Constants.defaultPadding / 2),
                          IconButton(
                            tooltip: 'Remove friend',
                            icon: SvgPicture.asset(
                              'res/icons/user_minus.svg',
                              colorFilter: const ColorFilter.mode(
                                  Colors.white54, BlendMode.srcIn),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
