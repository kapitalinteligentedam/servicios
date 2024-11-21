import 'dart:isolate';
import 'package:flutter/material.dart';

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  int _contador = 0;
  String _resultado = '';
  bool _procesando = false;
  static void _tareaPesada(SendPort sendPort) {
    int sum = 0;
    for (int i = 0; i <= 1000000000; i++) {
      sum += i;
    }
    sendPort.send(sum);
  }

  void _iniciarOperacion() async {
    setState(() {
      _procesando = true;
      _resultado = '';
    });

    final receivePort = ReceivePort();

    await Isolate.spawn(_tareaPesada, receivePort.sendPort);

    receivePort.listen((message) {
      setState(() {
        _procesando = false;
        _resultado = 'Resultado: $message';
      });
    });
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
                _procesando
                    ? const CircularProgressIndicator()
                    : Text('Presiona el boton para iniciar la cuenta'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _procesando ? null : _iniciarOperacion,
                  child: const Text('Iniciar operación'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _contador++;
                    });
                  },
                  child: const Text('Sumar 1'),
                ),
                Text('$_contador', style: const TextStyle(fontSize: 30))
              ],
            ),
          ),
        ));
  }
}
