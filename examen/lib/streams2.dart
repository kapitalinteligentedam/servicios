import 'package:flutter/material.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  late Stream<int> counterStream;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Inicializar el stream al entrar a la pantalla
    counterStream = createCounterStream(10); // Aquí puedes cambiar el número máximo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLoading = false; // Detener el indicador circular después de configurar el stream
      });
    });
  }

  Stream<int> createCounterStream(int max) async* {
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
        child: isLoading
            ? const CircularProgressIndicator()
            : StreamBuilder<int>(
                stream: counterStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return const Text('Stream finalizado');
                  } else if (snapshot.hasData) {
                    return Text(
                      'Contador: ${snapshot.data}',
                      style: const TextStyle(fontSize: 24),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    );
                  } else {
                    return const Text('Sin datos');
                  }
                },
              ),
      ),
    );
  }
}