import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/provider/friend_provider.dart';
import 'package:duo_client/provider/game_rule_provider.dart';
import 'package:duo_client/provider/game_statistic_provider.dart';
import 'package:duo_client/provider/played_games_provider.dart';
import 'package:duo_client/screens/home_screen.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/add_friend_dialog.dart';
import 'package:duo_client/widgets/duo_container.dart';
import 'package:duo_client/widgets/duo_header.dart';
import 'package:duo_client/widgets/friend_list_tile.dart';
import 'package:duo_client/widgets/notification_dialog.dart';
import 'package:duo_client/widgets/recent_game_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(apiProvider).getFriends(await ref.read(apiProvider).getToken());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'res/icons/menu.svg',
            colorFilter:
                const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
          ),
          onPressed: () {},
        ),
        title: const Text('DUO'),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'res/icons/bell.svg',
              colorFilter: const ColorFilter.mode(
                Colors.white54,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => const NotificationDialog());
            },
          ),
          const SizedBox(width: Constants.defaultPadding / 2),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: Constants.defaultPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const DuoHeader(title: 'Recently Played'),
              Consumer(builder: (context, ref, child) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: Constants.defaultPadding * 3),
                    child: ref
                            .read(gameStatisticProvider)
                            .gameStatistics
                            .isEmpty
                        ? const EmptySegmentText(text: 'No games played yet')
                        : Row(
                            children: [
                              const SizedBox(width: Constants.defaultPadding),
                              ...ref
                                  .watch(playedGamesProvider)
                                  .playedGames
                                  .map((playedGame) => RecentGameItem(
                                        playedGame: playedGame,
                                      )),
                            ],
                          ),
                  ),
                );
              }),
              DuoHeader(title: 'Your Gamerules', actions: [
                IconButton(
                  tooltip: 'Create new gamerule',
                  icon: SvgPicture.asset(
                    'res/icons/plus_circle.svg',
                    colorFilter: const ColorFilter.mode(
                      Colors.white54,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {},
                ),
              ]),
              Consumer(builder: (context, ref, child) {
                var gameRules = ref.watch(gameRuleProvider).gameRules;
                return gameRules.isEmpty
                    ? const EmptySegmentText(text: 'No gamerules yet')
                    : SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Constants.defaultPadding),
                            child: DuoContainer(
                              width: 150,
                              child: Center(
                                child: Text(
                                  gameRules[index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          itemCount: gameRules.length,
                        ),
                      );
              }),
              const SizedBox(height: Constants.defaultPadding * 2),
              DuoHeader(title: 'Friends', actions: [
                IconButton(
                  tooltip: 'Add friend',
                  icon: SvgPicture.asset(
                    'res/icons/user_plus.svg',
                    colorFilter: const ColorFilter.mode(
                      Colors.white54,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const AddFriendDialog(),
                    );
                  },
                ),
              ]),
              Flexible(
                child: Consumer(builder: (context, ref, child) {
                  var friendList = [...ref.watch(friendProvider).friends]
                    ..sort((a, b) => b.state.value.compareTo(a.state.value));
                  return friendList.isEmpty
                      ? const EmptySegmentText(text: 'No friends yet')
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => FriendListTile(
                            friend: friendList[index],
                          ),
                          itemCount: friendList.length,
                        );
                }),
              ),
              const SizedBox(height: Constants.defaultPadding * 4),
            ],
          ),
        ),
      ),
    );
  }
}
