import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/provider/storage_provider.dart';
import 'package:duo_client/screens/home_screen.dart';
import 'package:duo_client/screens/lobby_screen.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/get_user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(child: DuoApp()));
}

class DuoApp extends ConsumerStatefulWidget {
  const DuoApp({super.key});

  @override
  ConsumerState<DuoApp> createState() => _DuoAppState();
}

class _DuoAppState extends ConsumerState<DuoApp> {
  bool loginComplete = false;
  bool loginFailed = false;

  // handle login
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(storageProvider).init().then((_) {
        ref.read(apiProvider).init(ServerConnectionType.grpc);
      }).then((_) {
        print('trying to login');
        ref.read(apiProvider).loginUser(ref.read(storageProvider).userId);
      }).then((value) {
        if (value == 0) {
          print('Login successful');
          setState(() {
            loginComplete = true;
          });
        } else {
          // route to login/register screen
          print('Login failed');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loginComplete
        ? MaterialApp(
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
          )
        : MaterialApp(
            home: Scaffold(
            backgroundColor: Constants.bgColor,
            body: Center(
              child: loginFailed
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (SpinKitFadingFour(
                          color: Colors.white,
                          size: 30,
                        )),
                        SizedBox(height: 20),
                        Text(
                          'ToDo: Add a loading/splash screen.',
                          style: TextStyle(fontSize: 20, color: Colors.white70),
                        )
                      ],
                    )
                  : const GetUserDialog(),
            ),
          ));
  }
}
