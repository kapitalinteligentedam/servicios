import 'dart:async';

import 'package:flutter/material.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  contador() async* {
    int max = 20;
    for (int i = 0; i <= max; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Streams')),
      body: Center(child: 
      StreamBuilder(
        stream: contador(),
        builder: contador() )),
    );
  }
}
