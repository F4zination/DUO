import 'package:duo_client/provider/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:duo_client/utils/constants.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({super.key, required this.title});

  final String title;

  @override
  ConsumerState<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends ConsumerState<StartScreen> {
  late final ClientChannel channel;

  @override
  void initState() {
    super.initState();
    channel = ClientChannel(
      Constants.host,
      port: Constants.port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ref
                  .read(storageProvider)
                  .storage
                  .read(key: keyToUsername)
                  .toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  // Add code to send Hello World! to the server
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('Go to Login')),
            ElevatedButton(
                onPressed: () async {
                  // Add code to send Hello World! to the server
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: const Text('Go to Registration')),
          ],
        ),
      ),
    );
  }
}
