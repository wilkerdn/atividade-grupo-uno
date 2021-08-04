import 'package:flutter/material.dart';
import '../models/jogador.dart';
import '../providers/jogadores_providers.dart';
import 'package:provider/provider.dart';

class TelaFormJogador extends StatefulWidget {
  @override
  TelaFormJogadorState createState() => TelaFormJogadorState();
}

class TelaFormJogadorState extends State<TelaFormJogador> {
  final form = GlobalKey<FormState>();
  final dadosForm = Map<String, Object>();

  void saveForm(context, Jogador jogador) {
    var formValido = form.currentState.validate();

    form.currentState.save();

    final novoJogador = Jogador(
        id: jogador != null ? jogador.id : jogador,
        nome: dadosForm['nome'],
        contato: dadosForm['contato'],
        email: dadosForm['email'],
        senha: dadosForm['senha']);

    if (formValido) {
      if (jogador != null) {
        Provider.of<JogadorProvider>(context, listen: false)
            .patchJogador(novoJogador);
        Navigator.of(context).pop();
      } else {
        Provider.of<JogadorProvider>(context, listen: false)
            .postJogadores(novoJogador);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final jogador = ModalRoute.of(context).settings.arguments as Jogador;
    print(jogador);
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário Jogador"),
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
                decoration: InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                initialValue: jogador != null ? jogador.nome : '',
                onSaved: (value) {
                  dadosForm['nome'] = value;
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Informe um nome válido";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contato'),
                textInputAction: TextInputAction.done,
                onSaved: (value) {
                  dadosForm['contato'] = value;
                },
                initialValue: jogador != null ? jogador.contato : '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                textInputAction: TextInputAction.done,
                onSaved: (value) {
                  dadosForm['email'] = value;
                },
                initialValue: jogador != null ? jogador.email : '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                textInputAction: TextInputAction.done,
                onSaved: (value) {
                  dadosForm['senha'] = value;
                },
                initialValue: jogador != null ? jogador.senha : '',
                onFieldSubmitted: (_) {
                  saveForm(context, jogador);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
