import 'package:flutter/material.dart';

class Jogador {
  final String id;
  final String nome;
  final String contato;
  final String email;
  final String senha;

  const Jogador({
    @required this.id,
    @required this.nome,
    @required this.contato,
    @required this.email,
    @required this.senha,
  });
}
