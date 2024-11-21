import 'package:exmen/streamscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StreamScreen(),
      routes: {
        'stream': (context) => const StreamScreen(),
      },
    );
  }
}
