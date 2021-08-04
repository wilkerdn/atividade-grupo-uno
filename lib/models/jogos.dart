import 'package:flutter/material.dart';

class Jogos {
  final String id;
  final String dataJogo;
  final int posicao;
  final int numJogadores;
  final String id_jogador;

  const Jogos({
    this.id,
    @required this.dataJogo,
    @required this.posicao,
    @required this.numJogadores,
    @required this.id_jogador,
  });
}
