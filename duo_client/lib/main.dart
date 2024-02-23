import 'package:duo_client/pb/request.pb.dart';
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
  late ClientChannel channel;
  bool _connected = false;
  late MessagingServiceClient messagingServiceClient;
  late ResponseStream responseStream;
  String message = 'No Message Received!';

  Future<void> connect() async {
    channel = ClientChannel(
      connectivity.host,
      port: connectivity.port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    messagingServiceClient = MessagingServiceClient(channel);
  }

  void sendMessage(String _name) async {
    final request = Request()..name = _name;
    try {
      await messagingServiceClient.send(request);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> disconnect() async {
    _connected = false;
    responseStream.cancel();
    await channel.shutdown();
  }

  Future<void> awaitServerResponse() async {
    print('Awaiting Stream!');
    final empty = Empty();
    responseStream = messagingServiceClient.connect(empty);
    responseStream.listen(
      (event) {
        debugPrint('Received: ${event.name}');
        setState(() {
          message = event.name;
        });
      },
      onDone: () {
        setState(() {
          message = 'End of Stream!';
        });
        debugPrint('End of Stream!');
      },
      onError: (e) {
        debugPrint('Error: $e');
      },
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
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                  onPressed: () async {
                    if (_connected) {
                      print('Already connected to server!');
                      return;
                    }
                    // Add code to send Hello World! to the server
                    await connect();
                    _connected = true;

                    awaitServerResponse();
                  },
                  child: const Text('Click to await Stream!')),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                  onPressed: () {
                    // disconnect from the server
                    disconnect();
                  },
                  child: const Text('Disconnect from Server')),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                  onPressed: () {
                    // send Hello World! to all clients
                    sendMessage('44er Bizeps');
                  },
                  child: const Text('Send Hello World! to all clients')),
            )
          ],
        ),
      ),
    );
  }
}
