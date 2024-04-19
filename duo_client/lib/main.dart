import 'package:duo_client/screens/home_screen.dart';
import 'package:duo_client/screens/lobby_screen.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(child: DuoApp()));
}

class DuoApp extends StatelessWidget {
  const DuoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Duo Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Constants.primaryColor,
          primary: Constants.primaryColor,
          primaryContainer: Constants.primaryColorAccent,
          secondary: Constants.secondaryColor,
          background: Constants.bgColor,
          surface: Constants.bgColor,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onBackground: Colors.white,
          onSurface: Colors.white,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
              Colors.white10,
            ),
          ),
        ),
        textTheme: GoogleFonts.aDLaMDisplayTextTheme(),
      ),
      initialRoute: HomeScreen.route,
      routes: {
        HomeScreen.route: (context) => const HomeScreen(),
        LobbyScreen.route: (context) => const LobbyScreen(),
      },
    );
  }
}
