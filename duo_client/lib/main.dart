import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:duo_client/utils/conectivity.dart' as connectivity;
import 'package:duo_client/pb/messaging_svc.pbgrpc.dart';
import 'package:duo_client/pb/empty.pb.dart';

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
  late final MessagingServiceClient messagingServiceClient;
  String message = 'No Message Received!';

  @override
  void initState() {
    super.initState();
    channel = ClientChannel(
      connectivity.host,
      port: connectivity.port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    messagingServiceClient = MessagingServiceClient(channel);
  }

  Future<String> awaitServerResponse() async {
    print('Awaiting Stream!');
    final empty = Empty();
    var responseStream = messagingServiceClient.connect(empty);
    await for (var response in responseStream) {
      print('Received: ${response.name}');
      setState(() {
        message = response.name;
      });
    }
    await channel.shutdown();
    return 'No Message Received!';
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
                  awaitServerResponse();
                },
                child: const Text('Click to await Stream!')),
          ],
        ),
      ),
    );
  }
}
