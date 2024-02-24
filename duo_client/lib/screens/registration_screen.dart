import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/utils/connection/abstract_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final TextEditingController _usernameController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ),
            loading ? const CircularProgressIndicator() : const SizedBox(),
            ElevatedButton(
              onPressed: () {
                final ApiProvider _apiProvider = ref.read(apiProvider);
                _apiProvider.init(ServerConnectionType.grpc);
                final AbstractServerConnection _serverConnection =
                    _apiProvider.serverConnection!;
                setState(() {
                  loading = true;
                });
                _serverConnection.registerUser(_usernameController.text).then(
                  (value) {
                    if (value == 0) {
                      Navigator.pushReplacementNamed(context, '/');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                          'Failed to register user',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red),
                        )),
                      );
                    }
                  },
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
