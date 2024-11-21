import 'package:flutter/material.dart';
import 'package:flutter_examen/isolatescreen.dart';
import 'package:flutter_examen/streamscreen.dart';

void main() {
  runApp(const MainApp());
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
