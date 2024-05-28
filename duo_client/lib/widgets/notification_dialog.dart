import 'package:duo_client/pb/friend.pb.dart';
import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/provider/notification_provider.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/friend_request_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NotificationDialog extends ConsumerStatefulWidget {
  const NotificationDialog({super.key});

  @override
  ConsumerState<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends ConsumerState<NotificationDialog> {
  bool _isLoading = false;
  List<FriendRequest> _friendRequests = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() => _isLoading = true);
      final reqs = await ref
          .read(apiProvider)
          .getFriendRequests(await ref.read(apiProvider).getToken());

      setState(() {
        _isLoading = false;
        _friendRequests = reqs;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Constants.secondaryColorDark,
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
          width: 400,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: Constants.defaultPadding,
              ),
              const Text('NOTIFICATIONS',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70)),
              const SizedBox(height: Constants.defaultPadding),
              _isLoading
                  ? const Expanded(
                      child: Center(
                          child: SpinKitHourGlass(
                      color: Constants.primaryColor,
                    )))
                  : Expanded(
                      child: ref
                                  .read(notificationProvider)
                                  .notifications
                                  .isEmpty &&
                              _friendRequests.isEmpty
                          ? const Center(
                              child: Text('No notifications',
                                  style: TextStyle(color: Colors.white)))
                          : ListView.builder(
                              itemCount: _friendRequests.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(
                                      Constants.defaultPadding / 2),
                                  child: FriendRequestTile(
                                      friendRequest: _friendRequests[index]),
                                );
                              },
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
