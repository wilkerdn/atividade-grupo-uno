import 'package:flutter/material.dart';
import '../componentes/drawer_personalizado.dart';
import '../componentes/item_jogador.dart';
import '../componentes/item_jogos.dart';
import '../models/jogos.dart';
import '../models/jogador.dart';
import '../providers/jogos_providers.dart';
import '../providers/jogadores_providers.dart';
import '../utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaJogos extends StatefulWidget {
  @override
  _TelaJogosState createState() => _TelaJogosState();
}

class _TelaJogosState extends State<TelaJogos> {
  bool _isLoading = false;
  Future<void> _atualizarLista(BuildContext context, Jogador jogador) {
    return Provider.of<JogadorProvider>(context, listen: false).buscaJogador();
  }

  @override
  Widget build(BuildContext context) {
    final jogador = ModalRoute.of(context).settings.arguments as Jogador;
    final jogos = Provider.of<JogosProvider>(context).getJogador;
    Provider.of<JogosProvider>(context).buscaJogos(jogador);
    print(jogos);
    return Scaffold(
      appBar: AppBar(
        title: Text("Jogador - ${jogador.nome}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                Rotas.FORM_JOGOS,
                arguments: jogador,
              );
            },
          )
        ],
      ),
      drawer: DrawerPersonalisado(),
      body: RefreshIndicator(
        onRefresh: () => _atualizarLista(context, jogador),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: jogos.length,
            itemBuilder: (ctx, i) => Column(
              children: [
                ItemListaJogos(jogos[i]),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
