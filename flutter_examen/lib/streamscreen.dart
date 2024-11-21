import 'package:flutter/material.dart';


class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  Stream<int> contadorStream(int max) async* {
    for (int i = 0; i<= max; i++){
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Streams')),
      body: Center(
          child: StreamBuilder(
            stream: contadorStream(10),
        builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();

        }else if( snapshot.connectionState == ConnectionState.done){
          return const Text("Stream Finalizado", style: TextStyle(fontSize: 30),);

        } else{
          return Text ('Contador : ${snapshot.data}', style:const TextStyle(fontSize: 30));
        }
           
        },),),);
  }
}
