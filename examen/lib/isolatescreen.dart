import 'dart:isolate';
import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';
import 'package:flutter/material.dart';

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  int? _resultado;
  bool _estado = false;
  int _contador = 0;

  sumar() async {
    setState(() {
      _estado = true;
    });

    ReceivePort receptor = ReceivePort();

    await Isolate.spawn(_tareaPesada, receptor.sendPort);
    setState(() {
      _resultado = receptor.sendPort as int;
      _estado = false;
      receptor.close();
    });
  }

  Future<VoidCallbackAction> _tareaPesada(SendPort sendPort) {
    int sum = 0;
    for (int i = 0; i <= 1000000000; i++) {
      sum += i;
    }
    return sendPort(sum);
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
                _resultado == null
                    ? Text(_resultado.toString())
                    : _estado
                        ? const CircularProgressIndicator()
                        : const Text('Presiona el botón para iniciar la cuenta',
                            style: TextStyle(fontSize: 30)),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: _estado ? () {} : sumar(),
                  child: _estado ? null : const Text('Iniciar operación'),
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
                Text('$_contador', style: const TextStyle(fontSize: 30))
              ],
            ),
          ),
        ));
  }
}
