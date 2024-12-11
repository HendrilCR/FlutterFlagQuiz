import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class SecondRoute extends StatefulWidget {
  const SecondRoute({super.key});

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  List<Map<String, String>> _countries = [];
  Map<String, String> _correctCountry = {};
  List<Map<String, String>> _buttonData = [];
  String _flagImagePath = "";
  int _score = 0;
  Map<String, bool?> _buttonColors = {}; // Mapa para controlar as cores dos botões
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _loadCountries();
    _loadScore();
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
          _buttonColors = {for (var country in _buttonData) country['nome']!: null}; // Inicializa as cores
          _answered = false;
        });
      } else {
        print('Estrutura JSON inválida: faltando array "paises"');
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
    if (_answered) return; // Impede cliques múltiplos após a resposta

    setState(() {
      _answered = true;
        _buttonColors.updateAll((key, value) {
          if (key == _correctCountry['nome']) {
            return true; // Verde para a correta
          } else if (key == country['nome'] && key!= _correctCountry['nome']){
            return false; // Vermelho para as incorretas que foram clicadas
          }else{
            return null;
          }
        });
      if (country['nome'] == _correctCountry['nome']) {
        _score++;
        _saveScore();
        print('Correto! A bandeira é de ${country['nome']}');
      } else {
        print('Errado. Tente novamente!');
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
        middle: Text('Pontuação: $_score'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_flagImagePath.isNotEmpty)
              Image.asset(
                _flagImagePath,
                width: 100,
                height: 60,
              ),
            if (_buttonData.isNotEmpty) ...[
              for (var country in _buttonData)
                Padding( // Adiciona um padding para espaçamento entre os botões
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CupertinoButton(
                      color: _buttonColors[country['nome']] == true
                          ? CupertinoColors.activeGreen
                          : _buttonColors[country['nome']] == false ?CupertinoColors.destructiveRed: null,
                      onPressed: () => _onButtonPressed(country),
                      child: Text(country['nome']!),
                    ),
                ),
            ] else
              const CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}