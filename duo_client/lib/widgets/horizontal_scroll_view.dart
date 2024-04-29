import 'package:flutter/material.dart';

class CardScrollView extends StatefulWidget {
  const CardScrollView({super.key});

  @override
  State<CardScrollView> createState() => _CardScrollViewState();
}

class _CardScrollViewState extends State<CardScrollView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
