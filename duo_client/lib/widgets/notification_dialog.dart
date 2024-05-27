import 'package:duo_client/provider/notification_provider.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationDialog extends ConsumerWidget {
  const NotificationDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              Expanded(
                child: ref.read(notificationProvider).notifications.isEmpty
                    ? const Center(
                        child: Text('No notifications',
                            style: TextStyle(color: Colors.white)))
                    : ListView.builder(
                        itemCount:
                            ref.read(notificationProvider).notifications.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              ref
                                  .watch(notificationProvider)
                                  .notifications[index]
                                  .data,
                              style: const TextStyle(color: Colors.white),
                            ),
                            trailing: IconButton(
                              icon:
                                  const Icon(Icons.close, color: Colors.white),
                              onPressed: () {
                                ref
                                    .read(notificationProvider)
                                    .removeNotification(index);
                              },
                            ),
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
