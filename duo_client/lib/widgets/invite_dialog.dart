import 'package:duo_client/pb/friend.pb.dart';
import 'package:duo_client/provider/friend_provider.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/friend_list_tile.dart';
import 'package:duo_client/widgets/qr_join_dialog.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

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
              const SizedBox(height: Constants.defaultPadding),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.defaultPadding * 2),
                child: Row(
                  children: [
                    Text(
                      'Join via Code:  ${invideCode.toString()}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => showDialog(
                          context: context,
                          builder: (context) => QrJoinDialog(
                                id: invideCode.toString(),
                              )),
                      icon: const Icon(
                        Icons.qr_code_2_rounded,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(width: Constants.defaultPadding / 2),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.white54),
                      onPressed: () async {
                        await Share.share(
                            'Join me on Duo using this code: *$invideCode*');
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: Constants.defaultPadding),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:
                    const Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: Constants.defaultPadding),
            ],
          )),
    );
  }
}
