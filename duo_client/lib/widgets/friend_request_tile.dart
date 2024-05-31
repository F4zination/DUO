import 'package:duo_client/pb/friend.pb.dart';
import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/provider/notification_provider.dart';
import 'package:duo_client/provider/storage_provider.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/utils/helpers.dart';
import 'package:duo_client/widgets/duo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendRequestTile extends ConsumerWidget {
  final FriendRequest friendRequest;
  const FriendRequestTile({required this.friendRequest, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DuoContainer(
      child: Row(
        children: [
          Helpers.getCircleAvatar(text: friendRequest.requesterName),
          const SizedBox(width: Constants.defaultPadding / 2),
          Text(
            'Freundschaftsanfrage von ${friendRequest.requesterName}',
            style: const TextStyle(
                color: Colors.white70, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.check, color: Colors.white),
            onPressed: () async {
              await ref.read(apiProvider).answerFriendRequest(
                    // TODO: this requires the token the target user
                    await ref.read(apiProvider).getToken(),
                    ref.read(storageProvider).userId,
                    true,
                  );
              // ref.read(notificationProvider).removeNotification();
            },
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
