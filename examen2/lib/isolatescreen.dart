import 'dart:isolate';
import 'package:flutter/material.dart';

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}
class _IsolateScreenState extends State<IsolateScreen> {
  int? resultado;
  bool calculando = false;
  int contador = 0;

  Future<void> suma() async {
    setState(() {
      calculando = true;
    });

    final receptor = ReceivePort();

    await Isolate.spawn(_tareaPesada, receptor.sendPort);

    receptor.listen((mensaje) {
      setState(() {
        resultado = mensaje;
        calculando = false;
      });
      receptor.close();
    });
  }
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
                const Text('Presiona el botón para iniciar la cuenta',
               style:  TextStyle(fontSize: 30)),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed: () {
                  
                },
                  child: const Text('Iniciar operación'), 
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Sumar 1'),
                  onPressed: () {
                    setState(() {
                      contador++;
                    });
                  },
                ),
                Text('$contador', style: const TextStyle(fontSize: 30))
              ],
            ),
          ),
        ));
  }
}
