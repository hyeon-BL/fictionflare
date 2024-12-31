import 'package:flutter/material.dart';


class GameLoadingScreen extends StatelessWidget {
  const GameLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Game Loading...'),
      ),
    );
  }
}