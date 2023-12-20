import 'package:flutter/material.dart';
import 'dart:async';

class CompleterExample extends StatefulWidget {
  const CompleterExample({super.key});

  @override
  State<CompleterExample> createState() => _CompleterExampleState();
}

class _CompleterExampleState extends State<CompleterExample> {
  

  @override
  Widget build(BuildContext context)  {
    doSomething();
    return const Placeholder();
  }

  Future<void> doSomething()  async {
    var completer = Completer<int>();

    // Simulando uma operação assíncrona que será concluída após 2 segundos.
    Future.delayed(Duration(seconds: 2), () {
      completer.complete(42);
    });

    // Obtendo o Future associado ao Completer.
    var futureResult = completer.future;

    // Aguardando a conclusão da computação assíncrona.
    futureResult.then((value) {
      print('Resultado: $value');
    }).catchError((error) {
      print('Erro: $error');
    });
  }
}
