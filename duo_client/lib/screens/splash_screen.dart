import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen<T> extends StatefulWidget {
  static const route = '/splash_in_your_face';
  final Future<T> Function() onLoading;
  final void Function(T value) onLoadingComplete;
  const SplashScreen({
    required this.onLoading,
    required this.onLoadingComplete,
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplasScreenState<T>();
}

class _SplasScreenState<T> extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      T value = await widget.onLoading();
      widget.onLoadingComplete(value);
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCube(
          color: Theme.of(context).colorScheme.primary,
          size: 50.0,
        ),
      ),
    );
  }
}
