import 'dart:isolate';
import 'package:flutter/material.dart';

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  int _contador = 0;
  bool _isProcessing = false;
  String? _resultado;

  static Future<int> _tareaPesada() async {
    int sum = 0;
    for (int i = 0; i <= 1000000000; i++) {
      sum += i;
    }
    return sum;
  }

  void _iniciarOperacion() async {
    setState(() {
      _isProcessing = true;
      _resultado = null;
    });

    // Crear y usar un isolate para la tarea pesada
    final receivePort = ReceivePort();
    await Isolate.spawn(_isolateTask, receivePort.sendPort);

    // Esperar el resultado del isolate
    final sum = await receivePort.first as int;

    setState(() {
      _isProcessing = false;
      _resultado = 'Resultado: $sum';
    });
  }

  static void _isolateTask(SendPort sendPort) async {
    final result = await _tareaPesada();
    sendPort.send(result);
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
              if (_isProcessing)
                const CircularProgressIndicator()
              else if (_resultado != null)
                Text(
                  _resultado!,
                  style: const TextStyle(fontSize: 30),
                )
              else
                Text(
                  'Presiona el botón para iniciar la cuenta',
                  style: const TextStyle(fontSize: 30),
                ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Iniciar operación'),
                onPressed: _isProcessing ? null : _iniciarOperacion,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Sumar 1'),
                onPressed: () {
                  setState(() {
                    _contador++;
                  });
                },
              ),
              Text('$_contador', style: const TextStyle(fontSize: 30)),
            ],
          ),
        ),
      ),
    );
  }
}