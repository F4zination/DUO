import 'package:duo_client/pb/friend.pb.dart';
import 'package:duo_client/provider/friend_provider.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/friend_list_tile.dart';
import 'package:flutter/material.dart';

class InviteDialog extends StatelessWidget {
  InviteDialog({super.key, required this.invideCode});

  late final Friend friendInvited;
  final int invideCode;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Constants.secondaryColorDark,
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
          width: 400,
          height: 450,
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
                children: FriendProvider().friends.map((friend) {
                  return FriendListTile(
                    showIcons: false,
                    friend: friend,
                    onTap: () {
                      friendInvited = friend;
                      Navigator.of(context).pop(friendInvited);
                    },
                  );
                }).toList(),
              )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Join via Code:  ${invideCode.toString()}',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          )),
    );
  }
}
