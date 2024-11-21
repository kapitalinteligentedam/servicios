import 'package:flutter/material.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class  _StreamScreenState extends State<StreamScreen> {

  for(int i = 0; i <= max; i++) async {
  await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Streams')),
      body: Center(
           child: Container(
            child: Row(
            Text: "Stram Finalizado"
            ),
           ),
          ),
    );
  }
}
