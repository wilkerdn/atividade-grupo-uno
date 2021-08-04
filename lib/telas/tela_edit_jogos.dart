import 'package:flutter/material.dart';
import '../models/jogos.dart';
import '../providers/jogos_providers.dart';
import 'package:provider/provider.dart';

class TelaEditJogos extends StatefulWidget {
  @override
  TelaEditJogosState createState() => TelaEditJogosState();
}

class TelaEditJogosState extends State<TelaEditJogos> {
  final form = GlobalKey<FormState>();
  final dadosForm = Map<String, Object>();

  void saveForm(context, Jogos jogo) {
    var formValido = form.currentState.validate();

    form.currentState.save();

    final novoJogo = Jogos(
      id: jogo.id,
      dataJogo: dadosForm['dataJogo'],
      numJogadores: int.parse(dadosForm['numJogadores']),
      posicao: int.parse(dadosForm['posicao']),
      id_jogador: jogo.id_jogador,
    );

    if (formValido) {
      Provider.of<JogosProvider>(context, listen: false).patchJogos(novoJogo);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final jogos = ModalRoute.of(context).settings.arguments as Jogos;
    print(jogos);
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário Jogo"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                saveForm(context, jogos);
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
                initialValue: jogos.dataJogo,
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
                initialValue: jogos.posicao.toString(),
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
                initialValue: jogos.numJogadores.toString(),
                onSaved: (value) {
                  dadosForm['numJogadores'] = value;
                },
                onFieldSubmitted: (_) {
                  saveForm(context, jogos);
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
