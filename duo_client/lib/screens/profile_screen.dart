import 'package:duo_client/provider/storage_provider.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    String username = ref.watch(storageProvider).username;

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
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'res/icons/pen.svg',
              colorFilter: const ColorFilter.mode(
                Colors.white54,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              // Navigator.of(context).pushReplacementNamed(GameScreen.route);
            },
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
      body: Padding(
        padding: const EdgeInsets.all(Constants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: Constants.defaultPadding,
              width: double.infinity,
            ),
            Helpers.getCircleAvatar(text: username, radius: 70, fontSize: 32),
            const SizedBox(height: Constants.defaultPadding),
            Text(
              username,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
            const SizedBox(height: Constants.defaultPadding * 2),
            Row(
              children: [
                Text(
                  'Score:',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white54),
                ),
                const Spacer(),
                Text(
                  '300',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white54),
                ),
              ],
            ),
            const SizedBox(height: Constants.defaultPadding),
            Row(
              children: [
                Text(
                  'Description:',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white54),
                ),
                const Spacer(),
                SizedBox(
                  width: 200,
                  child: Text(
                    'Ich bin ein Berliner!',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white54),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Constants.defaultPadding),
            Row(
              children: [
                Text(
                  'Joined on:',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white54),
                ),
                const Spacer(),
                Text(
                  '2021-09-01',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white54),
                ),
              ],
            ),
            const SizedBox(height: Constants.defaultPadding),
          ],
        ),
      ),
    );
  }
}
