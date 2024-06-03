import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/provider/storage_provider.dart';
import 'package:duo_client/screens/qr_scanner_screen.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/qr_join_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class AddFriendDialog extends ConsumerWidget {
  const AddFriendDialog({super.key});

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
              const Text('ADD FRIENDS',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70)),
              const SizedBox(height: Constants.defaultPadding),
              const SizedBox(height: Constants.defaultPadding),
              const Text(
                'Join via id:',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: Constants.defaultPadding),
              SizedBox(
                width: double.infinity,
                child: Text(
                  ref.read(storageProvider).userId,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: Constants.defaultPadding),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.defaultPadding * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => showDialog(
                          context: context,
                          builder: (context) => QrJoinDialog(
                                title:
                                    'Scan this QR code with the DUO app to join the group:',
                                data: ref.read(storageProvider).userId,
                              )),
                      icon: const Icon(
                        Icons.qr_code_2_rounded,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(width: Constants.defaultPadding / 2),
                    IconButton(
                      onPressed: () async {
                        final String? friendId = await Navigator.of(context)
                            .pushNamed(QrCodeScanner.route) as String?;
                        if (friendId != null) {
                          await ref.read(apiProvider).sendFriendRequest(
                              await ref.read(apiProvider).getToken(),
                              ref.read(storageProvider).username,
                              friendId);
                        }
                      },
                      icon: const Icon(
                        Icons.qr_code_scanner_rounded,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(width: Constants.defaultPadding / 2),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.white54),
                      onPressed: () async {
                        await Share.share(
                            'Add me as a friend with my id in DUO: *${ref.read(storageProvider).userId}*');
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
