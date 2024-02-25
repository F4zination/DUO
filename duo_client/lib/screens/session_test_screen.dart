import 'package:duo_client/provider/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:duo_client/provider/api_provider.dart';

class SessionTestScreen extends ConsumerStatefulWidget {
  const SessionTestScreen({super.key});

  @override
  ConsumerState<SessionTestScreen> createState() => _SessionTestScreeState();
}

class _SessionTestScreeState extends ConsumerState<SessionTestScreen> {
  String sessionId = '';
  List<String> sessionUsers = [];

  @override
  Widget build(BuildContext context) {
    final ApiProvider _apiProvider = ref.read(apiProvider);
    final StorageProvider _storageProvider = ref.read(storageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Column(
                children: [
                  Text('Session ID: $sessionId'),
                  Text('Session Users: $sessionUsers')
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  // add code
                  var token = await _storageProvider.storage
                      .read(key: keyToAccessToken);
                  _apiProvider.serverConnection!.createSession(token!, 1234);
                },
                child: const Text('Create Session (PIN: 1234)')),
            ElevatedButton(
                onPressed: () async {
                  // add code
                  var token = await _storageProvider.storage
                      .read(key: keyToAccessToken);
                  _apiProvider.serverConnection!
                      .joinSession(token!, 1234, 1234);
                },
                child: const Text('Join Session (ID: 1234 | PIN: 1234)')),
            ElevatedButton(
              onPressed: () {
                // Add code to send Hello World! to the server
              },
              child: const Text('Send Hello World!'),
            ),
          ],
        ),
      ),
    );
  }
}
