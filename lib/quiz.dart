import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'pontos.dart';

class SecondRoute extends StatefulWidget {
  final int valor;
  const SecondRoute({super.key, required this.valor});

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  List<Map<String, String>> _countries = [];
  Map<String, String> _correctCountry = {};
  List<Map<String, String>> _buttonData = [];
  String _flagImagePath = "";
  int _score = 0;
  Map<String, bool?> _buttonColors = {};
  bool _answered = false;

  int _timeLeft = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _loadCountries();
    _loadScore();
    _timeLeft = widget.valor;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer.cancel();
        _goToPontosScreen();
      }
    });
  }

  void _goToPontosScreen() {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => PontosRoute(pontos: _score)),
    );
  }

  Future<void> _loadCountries() async {
    try {
      final String response = await rootBundle.loadString('assets/paises.json');
      final Map<String, dynamic> data = json.decode(response);

      if (data['paises'] != null && data['paises'] is List) {
        List<dynamic> paises = data['paises'];
        _countries = paises
            .map((pais) => {
                  'nome': pais['nome'] as String,
                  'sigla': pais['sigla'] as String,
                  'bandeira': pais['bandeira'] as String,
                })
            .toList();
        _countries.shuffle();
        _correctCountry = _countries[Random().nextInt(_countries.length)];
        setState(() {
          _flagImagePath = _correctCountry['bandeira']!;
          _buttonData = _countries.take(4).toList();
          bool correctCountryInOptions = _buttonData.any((country) => country['nome'] == _correctCountry['nome']);
          if (!correctCountryInOptions) {
            _buttonData[Random().nextInt(4)] = _correctCountry;
          }
          _buttonData.shuffle();
          _buttonColors = {for (var country in _buttonData) country['nome']!: null};
          _answered = false;
        });
      }
    } catch (e) {
      print('Erro ao carregar JSON: $e');
    }
  }

  Future<void> _loadScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _score = prefs.getInt('score') ?? 0;
    });
  }

  Future<void> _saveScore() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('score', _score);
  }

  void _onButtonPressed(Map<String, String> country) {
    if (_answered) return;

    setState(() {
      _answered = true;
      _buttonColors.updateAll((key, value) {
        if (key == _correctCountry['nome']) {
          return true;
        } else if (key == country['nome'] && key != _correctCountry['nome']) {
          return false;
        } else {
          return null;
        }
      });
      if (country['nome'] == _correctCountry['nome']) {
        _score++;
        _saveScore();
      }
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      _loadCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Pontuação: $_score',
          style: const TextStyle(color: CupertinoColors.white), // Cor branca no texto da barra
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tempo restante: $_timeLeft Segundos',
              style: const TextStyle(color: CupertinoColors.white), // Cor branca no texto
            ),
            if (_flagImagePath.isNotEmpty)
              Image.asset(
                _flagImagePath,
                width: 200,
                height: 120,
              ),
            if (_buttonData.isNotEmpty) ...[
              for (var country in _buttonData)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CupertinoButton(
                    color: _buttonColors[country['nome']] == true
                        ? const Color.fromARGB(255, 52, 199, 108)
                        : _buttonColors[country['nome']] == false
                            ? const Color.fromARGB(255, 230, 42, 67)
                            : null,
                    onPressed: () => _onButtonPressed(country),
                    child: Text(
                      country['nome']!,
                      style: const TextStyle(color: CupertinoColors.white), // Cor branca no texto do botão
                    ),
                  ),
                ),
            ] else
              const CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
