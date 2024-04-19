import 'package:duo_client/pb/friend.pb.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/friend_list_tile.dart';
import 'package:flutter/material.dart';

class InviteDialog extends StatelessWidget {
  InviteDialog({super.key});

  late final Friend friendInvited;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Constants.secondaryColorDark,
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
          width: 400,
          height: 370,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text('INVITE FRIENDS',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70)),
              const SizedBox(height: 20),
              Expanded(
                  child: ListView(
                children: [
                  FriendListTile(
                    showIcons: false,
                    friend: Friend()
                      ..name = 'Adrianus'
                      ..state = FriendState.online,
                    onTap: () {
                      print('Invite Zinsi');
                    },
                  ),
                  FriendListTile(
                    showIcons: false,
                    friend: Friend()
                      ..name = 'Zinsi'
                      ..state = FriendState.inGame,
                    onTap: () {
                      print('Invite Zinsi');
                    },
                  ),
                  FriendListTile(
                    showIcons: false,
                    friend: Friend()
                      ..name = 'Gabriel'
                      ..state = FriendState.offline,
                    onTap: () {
                      print('Invite Zinsi');
                    },
                  ),
                  FriendListTile(
                    showIcons: false,
                    friend: Friend()
                      ..name = 'Lenni'
                      ..state = FriendState.online,
                    onTap: () {
                      print('Invite Zinsi');
                    },
                  ),
                ],
              ))
            ],
          )),
    );
  }
}
