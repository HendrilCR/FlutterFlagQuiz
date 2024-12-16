import 'package:flutter/cupertino.dart';
import 'dart:io';  // Necessário para a função exit(0)

class PontosRoute extends StatelessWidget {
  final int pontos;
  const PontosRoute({super.key, required this.pontos});

  @override
  Widget build(BuildContext context) {
    String mensagem = '';

    // Lógica para ajustar a mensagem com base nos pontos
    if (pontos == 0) {
      mensagem = 'Você não acertou nenhuma bandeira';
    } else if (pontos == 1) {
      mensagem = 'Você acertou 1 bandeira';
    } else {
      mensagem = 'Você acertou $pontos bandeiras';
    }

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Resultado'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mensagem),  // Exibe a mensagem ajustada
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CupertinoButton.filled(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Jogar novamente',
                  style: TextStyle(color: CupertinoColors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CupertinoButton(
                color: CupertinoColors.systemGrey,
                onPressed: () {
                  exit(0); // Fecha a aplicação
                },
                child: const Text(
                  'Sair',
                  style: TextStyle(color: CupertinoColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
