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
  String successfull = 'false';

  @override
  Widget build(BuildContext context) {
    final ApiProvider _apiProvider = ref.read(apiProvider);
    if (_apiProvider.serverConnection == null) {
      _apiProvider.init(ServerConnectionType.grpc);
    }
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
                  Text('Successful: $successfull')
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  // add code
                  var token = await _storageProvider.storage
                      .read(key: keyToAccessToken);

                  // create Session
                  _apiProvider.serverConnection!
                      .createSession(token!, '1234')
                      .then((value) async {
                    print('value = $value');
                    // join Session
                    if (value == 0) return;
                    int _sessionID = await _apiProvider.serverConnection!
                        .joinSession(token, value, '1234');
                    if (_sessionID == 0) {
                      setState(() {
                        sessionId = _sessionID.toString();
                        successfull = 'true';
                      });
                    }
                  });
                },
                child: const Text('Create Session (PIN: 1234)')),
            ElevatedButton(
                onPressed: () async {
                  // add code
                  var token = await _storageProvider.storage
                      .read(key: keyToAccessToken);
                  _apiProvider.serverConnection!
                      .joinSession(token!, int.parse(sessionId), '1234');
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
