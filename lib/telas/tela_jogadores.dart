import 'package:flutter/material.dart';
import '../componentes/drawer_personalizado.dart';
import '../componentes/item_jogador.dart';
import '../providers/jogadores_providers.dart';
import '../utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaJogadores extends StatefulWidget {
  @override
  _TelaJogadoresState createState() => _TelaJogadoresState();
}

class _TelaJogadoresState extends State<TelaJogadores> {
  bool _isLoading = false;
  Future<void> _atualizarLista(BuildContext context) {
    return Provider.of<JogadorProvider>(context, listen: false).buscaJogador();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<JogadorProvider>(context, listen: false)
        .buscaJogador()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final jogador = Provider.of<JogadorProvider>(context).getJogador;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Jogadores"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(Rotas.FORM_JOGADOR);
            },
          )
        ],
      ),
      drawer: DrawerPersonalisado(),
      body: RefreshIndicator(
        onRefresh: () => _atualizarLista(context),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: jogador.length,
            itemBuilder: (ctx, i) => Column(
              children: [
                ItemListaJogador(jogador[i]),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
