import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:duo_client/utils/constants.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key, required this.title});

  final String title;

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late final ClientChannel channel;
  String message = 'Register or Login to continue';

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
              message,
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
