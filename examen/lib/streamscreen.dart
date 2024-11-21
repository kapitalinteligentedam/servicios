import 'package:flutter/material.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  Stream<int> contador (int max) async* {
  for (int i = 0; i <= max; i++) {
  await Future.delayed(const Duration(seconds: 1));
  yield i;
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Streams')),
      body: Center(
          child: StreamBuilder<int>(
            stream: contador(10), 
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Text('Contador hecho');
              } else {
                return Text('Contador ${snapshot.data}');
              }
            }
            )
          ),
    );
  }
}
