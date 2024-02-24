import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/utils/connection/abstract_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  // TODO: Change to Provider
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  final ApiProvider _apiProvider = ref.read(apiProvider);
                  _apiProvider.init(ServerConnectionType.grpc);
                  final AbstractServerConnection _serverConnection =
                      _apiProvider.serverConnection!;
                  String uuid =
                      await storage.read(key: 'userid') as String? ?? '';
                  print(uuid);
                  _serverConnection.loginUser(uuid).then((value) {
                    if (value == 0) {
                      Navigator.pushReplacementNamed(context, '/');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                          'Failed to login user',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red),
                        )),
                      );
                    }
                  });
                },
                child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
