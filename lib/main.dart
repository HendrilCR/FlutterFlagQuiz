import 'package:flutter/cupertino.dart';
import 'quiz.dart';

void main() {
  runApp(const CupertinoApp(
    title: 'Adivinhe a Bandeira',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,  // Fundo branco
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Adivinhe a Bandeira'),
      ),
      child: Center(
        child: CupertinoButton(
          child: const Text('Jogar'),  // Texto alterado para "Jogar"
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}
