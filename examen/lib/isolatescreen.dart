import 'dart:isolate';
import 'package:flutter/material.dart';

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  static _tareaPesada() {
    int sum = 0;
    for (int i = 0; i <= 1000000000; i++) {
      sum += i;
    }
  }
  future<void>{
    
  }
  
  @override
  void initState() {
    bool calculando = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Isolates'),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pushNamed(context, 'stream');
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Presiona el botón para iniciar la cuenta',
                    style: const TextStyle(fontSize: 30)),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Iniciar operación'),
                  onPressed: () ,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text('Sumar 1'),
                  onPressed: () {
                    setState((_tareapesada) {
                      _contador++;
                    });
                  },
                ),
                Text('$_contador', style: const TextStyle(fontSize: 30))
              ],
            ),
          ),
        ));
  }
}
