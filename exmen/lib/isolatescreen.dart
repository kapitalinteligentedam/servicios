import 'dart:isolate';
import 'package:flutter/material.dart';

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
    static _tareaPesada(SendPort sendport) {
    int sum = 0;
    for (int i = 0; i <= 1000000000; i++) {
      sum += i;
    }
    sendport.send(sum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar: AppBar(
          title: const Text('Isolates'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _calculando
                  ? CircularProgressIndicator()
                  : Text(
                      _resultado == null
                          ? 'Presiona el botón para iniciar la cuenta'
                          : '$_resultado',
                      style: const TextStyle(fontSize: 30)),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _calculando ? null : suma,
                child: const Text('Iniciar operación'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('Sumar 1'),
                onPressed: () {
                  setState(() {
                    _contador++;
                  });
                },
              ),
              Text('$_contador', style: const TextStyle(fontSize: 30))
            ],
          ),
        ));
  }
}

