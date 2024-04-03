import 'package:duo_client/provider/api_provider.dart';
import 'package:duo_client/provider/storage_provider.dart';
import 'package:duo_client/screens/dashboard_screen.dart';
import 'package:duo_client/screens/profile_screen.dart';
import 'package:duo_client/screens/splash_screen.dart';
import 'package:duo_client/widgets/first_time_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const route = '/home';
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isLoading = false;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const ProfileScreen(),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    //Put  initialization code here
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(storageProvider).init();
      ref.read(apiProvider).init(ServerConnectionType.grpc);
      //TODO delete
      ref.read(storageProvider).setIsFirstTime(true);
      setState(() {
        _isLoading = false;
      });
      if (ref.read(storageProvider).isFirstTime) {
        if (!mounted) return;
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => FirstTimeDialog(onNameSet: (name) async {
                  await ref.read(apiProvider).registerUser(name);
                  ref.read(storageProvider).setIsFirstTime(false);
                }));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const SplashScreen()
        : Scaffold(
            body: _screens[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
  }
}
