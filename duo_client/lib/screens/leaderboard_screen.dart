import 'package:duo_client/provider/friend_provider.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/leaderboard_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'res/icons/menu.svg',
            colorFilter:
                const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
          ),
          onPressed: () {},
        ),
        title: const Text('Leaderboard'),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'res/icons/refresh.svg',
              colorFilter: const ColorFilter.mode(
                Colors.white54,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: Constants.defaultPadding / 2),
          IconButton(
            icon: SvgPicture.asset(
              'res/icons/bell.svg',
              colorFilter: const ColorFilter.mode(
                Colors.white54,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: Constants.defaultPadding / 2),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, ref, child) {
            var friends = [...ref.watch(friendProvider).friends]..sort(
                (a, b) => b.score.compareTo(a.score),
              );
            //TODO add player to list

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: Constants.defaultPadding),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    return LeaderboardListTile(
                      boardPlace: index + 1,
                      friend: friends[index],
                      isBetterThanPlayer: friends[index].score > 100, //TODO
                      isPlayer: false, //TODO
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
