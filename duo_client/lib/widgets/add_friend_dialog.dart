import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/provider/storage_provider.dart';
import 'package:duo_client/screens/qr_scanner_screen.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/qr_join_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class AddFriendDialog extends ConsumerWidget {
  AddFriendDialog({super.key});
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String qrText =
        'Scan this QR code to send a FriendRequest to: ${ref.read(storageProvider).username}';
    return Dialog(
      backgroundColor: Constants.secondaryColorDark,
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
          width: 400,
          height: MediaQuery.of(context).size.height * 0.45,
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
              const Text(
                'Join via id:',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: Constants.defaultPadding),
              SizedBox(
                width: double.infinity,
                child: InkWell(
                  onLongPress: () => Clipboard.setData(
                      ClipboardData(text: ref.read(storageProvider).userId)),
                  child: Text(
                    ref.read(storageProvider).userId,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
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
                                title: qrText,
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
                          print('Friend id: $friendId');
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
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Constants.defaultPadding),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              ),
              const SizedBox(height: Constants.defaultPadding),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 2 * Constants.defaultPadding),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter friend id',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onSubmitted: (value) async {
                    ref.read(apiProvider).sendFriendRequest(
                        await ref.read(apiProvider).getToken(),
                        ref.read(storageProvider).username,
                        value);
                  },
                ),
              ),
              const SizedBox(height: Constants.defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        ref
                            .read(apiProvider)
                            .sendFriendRequest(
                                await ref.read(apiProvider).getToken(),
                                ref.read(storageProvider).username,
                                _controller.text)
                            .then((value) {
                          Navigator.of(context).pop();
                        });
                      },
                      child: const Text('Add',
                          style: TextStyle(color: Colors.white)))
                ],
              ),
              const SizedBox(height: Constants.defaultPadding),
            ],
          )),
    );
  }
}
