import 'package:flutter/cupertino.dart';
import 'quiz.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const CupertinoApp(
    title: 'Adivinhe a Bandeira',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  Future<void> _resetScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score', 0);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black, // Fundo preto
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black, // Cor de fundo da barra de navegação preta
        middle: const Text(
          'Adivinhe a Bandeira',
          style: TextStyle(color: CupertinoColors.white), // Cor do texto branco na barra de navegação
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
              color: CupertinoColors.systemRed, // Cor de fundo vermelha
              child: const Text(
                '15 Segundos',
                style: TextStyle(color: CupertinoColors.white), // Cor do texto branco
              ),
              onPressed: () async {
                await _resetScore();
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SecondRoute(valor: 15),
                  ),
                );
              },
            ),
            const SizedBox(height: 20), // Espaço de 20px entre os botões
            CupertinoButton(
              color: CupertinoColors.systemOrange, // Cor de fundo laranja
              child: const Text(
                '30 Segundos',
                style: TextStyle(color: CupertinoColors.white), // Cor do texto branco
              ),
              onPressed: () async {
                await _resetScore();
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SecondRoute(valor: 30),
                  ),
                );
              },
            ),
            const SizedBox(height: 20), // Espaço de 20px entre os botões
            CupertinoButton(
              color: CupertinoColors.systemYellow, // Cor de fundo amarela
              child: const Text(
                '45 Segundos',
                style: TextStyle(color: CupertinoColors.white), // Cor do texto branco
              ),
              onPressed: () async {
                await _resetScore();
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SecondRoute(valor: 45),
                  ),
                );
              },
            ),
            const SizedBox(height: 20), // Espaço de 20px entre os botões
            CupertinoButton(
              color: CupertinoColors.systemBlue, // Cor de fundo azul
              child: const Text(
                '60 Segundos',
                style: TextStyle(color: CupertinoColors.white), // Cor do texto branco
              ),
              onPressed: () async {
                await _resetScore();
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SecondRoute(valor: 60),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
