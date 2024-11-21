import 'package:flutter/material.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  contador(int max) async* {
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
        child: Column(
          children: [
            StreamBuilder(
                stream: contador(10),
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapShot.connectionState == ConnectionState.active){
                    return Text('Contador: ${snapShot.data}');
                  }else if (snapShot.connectionState == ConnectionState.done){
                    return Text('Contador finalizado');
                  } else {
                    return Text('Error');
                  }
                })
          ],
        ),
      ),
    );
  }
}
