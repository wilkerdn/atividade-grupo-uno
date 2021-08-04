import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/jogador.dart';
import 'package:http/http.dart' as http;
import '../models/jogos.dart';
import '../utils/variaveis.dart';

class JogosProvider with ChangeNotifier {
  List<Jogos> _jogos = [];

  List<Jogos> get getJogador => [..._jogos];

  void adicionarJogos(Jogos jogos) {
    _jogos.add(jogos);
    notifyListeners();
  }

  Future<void> postJogos(Jogos jogo) async {
    var url = Uri.https(
        Variaveis.BACKURL, '/jogadores/${jogo.id_jogador}/jogos.json');
    http
        .post(url,
            body: jsonEncode(
              {
                'dataJogo': jogo.dataJogo,
                "posicao": jogo.posicao,
                "numJogadores": jogo.numJogadores,
                "id_jogador": jogo.id_jogador,
              },
            ))
        .then((value) {
      adicionarJogos(jogo);
    });
  }

  //PARA FAZER REQUISIÇÕSE SINCRONAS DEVEMOS RETORNAR O FUTURE
  Future<void> buscaJogos(Jogador jogador) async {
    var url =
        Uri.https(Variaveis.BACKURL, '/jogadores/${jogador.id}/jogos.json');
    var resposta = await http.get(url);
    Map<String, dynamic> data = json.decode(resposta.body);
    _jogos.clear();
    if (data.isNotEmpty) {
      data.forEach((idJogos, dadosJogos) {
        adicionarJogos(
          Jogos(
            id: idJogos,
            dataJogo: dadosJogos['dataJogo'],
            posicao: dadosJogos['posicao'],
            numJogadores: dadosJogos['numJogadores'],
            id_jogador: dadosJogos['id_jogador'],
          ),
        );
      });
    }
    notifyListeners();
  }

  Future<void> deleteJogo(Jogos jogo) async {
    print('Teste: ${jogo.id}');
    var url = Uri.https(Variaveis.BACKURL,
        '/jogadores/${jogo.id_jogador}/jogos/${jogo.id}.json');

    http.delete((url)).then((value) {
      notifyListeners();
    });
  }

  Future<void> patchJogos(Jogos jogo) async {
    var url = Uri.https(Variaveis.BACKURL,
        '/jogadores/${jogo.id_jogador}/jogos/${jogo.id}.json');
    http
        .patch(url,
            body: jsonEncode(
              {
                'dataJogo': jogo.dataJogo,
                "posicao": jogo.posicao,
                "numJogadores": jogo.numJogadores,
              },
            ))
        .then((value) {
      notifyListeners();
    });
  }
}
