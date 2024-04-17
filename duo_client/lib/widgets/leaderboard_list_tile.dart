import 'package:duo_client/pb/friend.pb.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/utils/helpers.dart';
import 'package:duo_client/widgets/duo_container.dart';
import 'package:flutter/material.dart';

class LeaderboardListTile extends StatelessWidget {
  final int boardPlace;
  final Friend friend;
  final bool isBetterThanPlayer;
  final VoidCallback? onTap;
  final bool isPlayer;
  const LeaderboardListTile({
    required this.boardPlace,
    required this.friend,
    required this.isBetterThanPlayer,
    this.isPlayer = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DuoContainer(
      border: Border.all(
        color: isPlayer
            ? Constants.goldColor
            : Theme.of(context).colorScheme.secondary,
        width: 1,
      ),
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
                    child: switch (boardPlace) {
                      1 => Helpers.getTopThreeCircleAvatar(context, boardPlace),
                      2 => Helpers.getTopThreeCircleAvatar(context, boardPlace),
                      3 => Helpers.getTopThreeCircleAvatar(context, boardPlace),
                      _ => Helpers.getCircleAvatar(
                          text: friend.name,
                          displayedText: boardPlace.toString()),
                    }),
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
                Text(
                  isBetterThanPlayer
                      ? '+${friend.score.toString()}'
                      : '-${friend.score.toString()}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isBetterThanPlayer
                            ? Constants.successColor
                            : Constants.errorColor,
                      ),
                ),
                const SizedBox(
                  width: Constants.defaultPadding,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
