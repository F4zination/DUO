import 'package:flutter/material.dart';

class BackgroundScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final BottomNavigationBar? bottomNavigationBar;
  const BackgroundScaffold({
    required this.body,
    this.bottomNavigationBar,
    this.appBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: bottomNavigationBar,
      body: Stack(
        children: [
          const Image(
            image: AssetImage('res/images/background.png'),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          if (appBar != null) appBar!,
          Positioned.fill(
            top: appBar?.preferredSize.height ?? 0,
            child: SafeArea(child: body),
          ),
        ],
      ),
    );
  }
}
