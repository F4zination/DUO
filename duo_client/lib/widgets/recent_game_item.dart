import 'package:duo_client/models/game_statistic.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/duo_container.dart';
import 'package:flutter/material.dart';

class RecentGameItem extends StatelessWidget {
  final GameStatistic gameStatistic;
  final VoidCallback? onTap;
  const RecentGameItem({
    required this.gameStatistic,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Constants.defaultPadding),
      child: DuoContainer(
        width: 200,
        height: 120,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(Constants.defaultRadius),
            onTap: onTap ?? () {},
            child: Padding(
              padding: const EdgeInsets.all(Constants.defaultPadding),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: switch (gameStatistic.ownPlace) {
                      1 => Constants.goldColor,
                      2 => Constants.silverColor,
                      3 => Constants.bronzeColor,
                      _ => Theme.of(context).primaryColor,
                    },
                    child: Text(
                      switch (gameStatistic.ownPlace) {
                        1 => '🥇',
                        2 => '🥈',
                        3 => '🥉',
                        _ => '${gameStatistic.ownPlace}'
                      },
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(0.7),
                      ),
                    ),
                  ),
                  const SizedBox(width: Constants.defaultPadding),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          gameStatistic.gameTitle,
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
                          '${gameStatistic.playersBoard.length + 1} Players',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.54),
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
      ),
    );
  }
}
