import 'package:duo_client/pb/friend.pb.dart';
import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/provider/storage_provider.dart';
import 'package:duo_client/screens/game_screen.dart';
import 'package:duo_client/screens/home_screen.dart';
import 'package:duo_client/screens/lobby_screen.dart';
import 'package:duo_client/screens/qr_scanner_screen.dart';
import 'package:duo_client/screens/splash_screen.dart';
import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/get_user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Constants.primaryColor,
            ),
            overlayColor: MaterialStateProperty.all(
              Constants.primaryColorAccent,
            ),
          ),
        ),
        textTheme: GoogleFonts.aDLaMDisplayTextTheme(),
      ),
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (context) => SplashScreen(
              onLoading: () async {
                await ref.read(storageProvider).init();
                debugPrint(
                    'trying to connect to ${ref.read(storageProvider).grpcHost}');
                ref.read(apiProvider).init(ServerConnectionType.grpc);

                await ref.read(apiProvider).initUserStatusStream();
                ref.read(apiProvider).sendUserstatusUpdate(
                    await ref.read(apiProvider).getToken(), FriendState.online);
                return await ref
                    .read(apiProvider)
                    .loginUser(ref.read(storageProvider).userId);
              },
              onLoadingComplete: (dynamic status) {
                if (status == 0) {
                  Navigator.of(context).pushReplacementNamed(HomeScreen.route);
                } else {
                  debugPrint('User not found');
                  showDialog(
                    context: context,
                    builder: (context) => const GetUserDialog(),
                  );
                }
              },
            ),
        QrCodeScanner.route: (context) => const QrCodeScanner(),
        HomeScreen.route: (context) => const HomeScreen(),
        GameScreen.route: (context) => const GameScreen(),
        LobbyScreen.route: (context) => const LobbyScreen(),
      },
    );
  }
}
