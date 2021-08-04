import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/jogador.dart';
import 'package:http/http.dart' as http;
import '../utils/variaveis.dart';

class JogadorProvider with ChangeNotifier {
  List<Jogador> _jogador = [];
  String token;

  JogadorProvider(this.token, this._jogador);

  List<Jogador> get getJogador => [..._jogador];

  void adicionarJogador(Jogador jogador) {
    _jogador.add(jogador);
    notifyListeners();
  }

  Future<void> postJogadores(Jogador jogador) async {
    var url = Uri.https(Variaveis.BACKURL, '/jogadores.json');
    http
        .post(url,
            body: jsonEncode(
              {
                'nome': jogador.nome,
                'contato': jogador.contato,
                'email': jogador.email,
                'senha': jogador.senha
              },
            ))
        .then((value) {
      adicionarJogador(jogador);
    });
  }

  //MÉTODO PARA ATUALIZAR MONTADORAS
  Future<void> patchJogador(Jogador jogador) async {
    var url = Uri.https(Variaveis.BACKURL, '/jogadores/${jogador.id}.json');
    http
        .patch(url,
            body: jsonEncode(
              {
                'nome': jogador.nome,
                'contato': jogador.contato,
                'email': jogador.email,
                'senha': jogador.senha
              },
            ))
        .then((value) {
      buscaJogador();
      notifyListeners();
    });
  }

  //MÉTODO PARA APAGAR MONTADORAS
  Future<void> deleteJogador(Jogador jogador) async {
    var url = Uri.https(Variaveis.BACKURL, '/jogadores/${jogador.id}.json');
    http.delete((url)).then((value) {
      buscaJogador();
      notifyListeners();
    });
  }

  //PARA FAZER REQUISIÇÕSE SINCRONAS DEVEMOS RETORNAR O FUTURE
  Future<void> buscaJogador() async {
    var url = Uri.https(Variaveis.BACKURL, '/jogadores.json', {'auth': token});
    var resposta = await http.get(url);
    Map<String, dynamic> data = json.decode(resposta.body);
    _jogador.clear();
    data.forEach((idJogador, dadosJogador) {
      adicionarJogador(Jogador(
        id: idJogador,
        nome: dadosJogador['nome'],
        contato: dadosJogador['contato'],
        email: dadosJogador['email'],
        senha: dadosJogador['senha'],
      ));
    });
    notifyListeners();
  }
}
