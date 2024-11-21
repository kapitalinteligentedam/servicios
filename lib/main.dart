import 'package:flutter/material.dart';

import '../isolatescreen.dart';
import '../streamscreen.dart';

void main() {
  runApp(const MainApp());
}

void runApp(MainApp mainApp) {
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IsolateScreen(),
      routes: {
        'stream': (context) => const StreamScreen(),
      },
    );
  }
}
