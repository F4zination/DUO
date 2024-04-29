import 'package:duo_client/screens/dashboard_screen.dart';
import 'package:duo_client/screens/game_screen.dart';
import 'package:duo_client/screens/leaderboard_screen.dart';
import 'package:duo_client/screens/profile_screen.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/duo_bottom_nav_bar.dart';
import 'package:duo_client/widgets/game_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  static const route = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const DashboardScreen(),
    const LeaderboardScreen(),
    const ProfileScreen(),
    const DashboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _screens[_currentIndex],
        Positioned(
          bottom: 0,
          child: DuoBottomNavigationBar(
            onPlay: () {
              debugPrint('Play button pressed');
              showDialog(
                context: context,
                builder: (context) => const GameDialog(),
              );
            },
            onSelected: (index) => setState(() {
              debugPrint('Selected index: $index');
              _currentIndex = index;
            }),
            currentIndex: _currentIndex,
            items: const [
              DuoBottomNavigationItem(
                label: 'Home',
                icon: 'res/icons/house.svg',
              ),
              DuoBottomNavigationItem(
                label: 'Board',
                icon: 'res/icons/chart.svg',
              ),
              DuoBottomNavigationItem(
                label: 'Profile',
                icon: 'res/icons/user.svg',
              ),
              DuoBottomNavigationItem(
                label: 'Settings',
                icon: 'res/icons/settings.svg',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EmptySegmentText extends StatelessWidget {
  final String text;
  const EmptySegmentText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('res/icons/snooze.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onBackground.withOpacity(0.54),
                BlendMode.srcIn,
              )),
          const SizedBox(width: Constants.defaultPadding),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.54),
                ),
          ),
        ],
      ),
    );
  }
}
