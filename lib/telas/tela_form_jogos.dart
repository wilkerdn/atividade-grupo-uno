import 'package:flutter/material.dart';
import 'package:uno/models/jogador.dart';
import '../models/jogos.dart';
import '../models/jogador.dart';
import '../providers/jogos_providers.dart';
import 'package:provider/provider.dart';

class TelaFormJogos extends StatefulWidget {
  @override
  TelaFormJogosState createState() => TelaFormJogosState();
}

class TelaFormJogosState extends State<TelaFormJogos> {
  final form = GlobalKey<FormState>();
  final dadosForm = Map<String, Object>();

  void saveForm(context, Jogador jogador) {
    var formValido = form.currentState.validate();

    form.currentState.save();

    final novoJogo = Jogos(
      id: jogador != null ? jogador.id : jogador,
      dataJogo: dadosForm['dataJogo'],
      numJogadores: int.parse(dadosForm['numJogadores']),
      posicao: int.parse(dadosForm['posicao']),
      id_jogador: jogador.id,
    );

    if (formValido) {
      Provider.of<JogosProvider>(context, listen: false).postJogos(novoJogo);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    //final jogos = ModalRoute.of(context).settings.arguments as Jogos;
    final jogador = ModalRoute.of(context).settings.arguments as Jogador;
    print(jogador);
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário Jogo"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                saveForm(context, jogador);
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Data Jogo'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  dadosForm['dataJogo'] = value;
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Informe uma data válido";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Posição'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  dadosForm['posicao'] = value;
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Informe uma posição válida";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Jogadores'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  dadosForm['numJogadores'] = value;
                },
                onFieldSubmitted: (_) {
                  saveForm(context, jogador);
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Informe um valor válido";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
