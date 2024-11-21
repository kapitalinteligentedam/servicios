import 'dart:isolate';
import 'package:flutter/material.dart';

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

int contador = 0;
bool? calculando = false;
String? mensaje;

class _IsolateScreenState extends State<IsolateScreen> {
  var sendPort;

  inicio() async {
    setState(() async {
      calculando = true;

      final receptor = ReceivePort();
      await Isolate.spawn(_tareaPesada, receptor.sendPort);

      receptor.listen((mensaje) {
        setState(() {
          mensaje = mensaje;
          calculando = false;
        });
        receptor.close();
      });
    });
  }

  static _tareaPesada(SendPort) {
    int sum = 0;
    for (int i = 0; i <= 1000000000; i++) {
      sum += i;
    }
   
    SendPort.sendPort(sum);
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
                calculando != true
                    ? CircularProgressIndicator()
                    : Text('Presiona el botón para iniciar la cuenta',
                        style: const TextStyle(fontSize: 30)),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Iniciar operación'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text('Sumar 1'),
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
