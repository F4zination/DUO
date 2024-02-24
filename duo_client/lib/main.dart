import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:duo_client/utils/conectivity.dart' as connectivity;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DUO Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Duo Client'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ClientChannel channel;
  String message = 'No Message Received!';

  @override
  void initState() {
    super.initState();
    channel = ClientChannel(
      connectivity.host,
      port: connectivity.port,
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
            ElevatedButton(
                onPressed: () async {
                  // Add code to send Hello World! to the server
                },
                child: const Text('Click to await Stream!')),
          ],
        ),
      ),
    );
  }
}
