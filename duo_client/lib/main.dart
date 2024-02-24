import 'package:duo_client/screens/login_screen.dart';
import 'package:duo_client/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:duo_client/screens/start_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
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
      initialRoute: '/',
      routes: {
        '/': (context) => const StartScreen(title: 'Duo Client'),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen()
      },
    );
  }
}
