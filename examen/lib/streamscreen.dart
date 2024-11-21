import 'dart:math';

import 'package:flutter/material.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen>  {

  var max;
    streamBuilder() async{
    for (int i = 0; i <= max; i++) {
    await Future.delayed(const Duration(seconds: 1));
    }
  }
  

  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Streams')),
      body: Center(
           child:Column(
            children: [
              CircularProgressIndicator(),
              ElevatedButton(
                onPressed: (){
                  setState(){
                    if(ConnectionState.done == true){
                      Text("Stream finalizado");
                    }else if(ConnectionState.waiting == true){
                      CircularProgressIndicator;
                    }else(){
                      Text("Ha ocurrido algun error");
                    };
                  }
                }, 
                child: Text("g"))
            ],

           ),
              
          ),
    );
  }
}
