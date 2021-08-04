import 'package:flutter/material.dart';
import '../models/jogador.dart';
import '../providers/jogadores_providers.dart';
import '../utils/rotas.dart';
import 'package:provider/provider.dart';

class ItemListaJogador extends StatelessWidget {
  final Jogador jogador;

  ItemListaJogador(this.jogador);

  void deleteJogador(context, Jogador jogador) {
    Provider.of<JogadorProvider>(context, listen: false).deleteJogador(jogador);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      tileColor: Colors.green[400],
      title: Container(
        child: Text(
          '${jogador.nome}\n${jogador.contato}\n${jogador.email}',
          style: TextStyle(color: Colors.black),
        ),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            Flexible(
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.amber,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Rotas.FORM_JOGADOR,
                    arguments: jogador,
                  );
                },
                color: Colors.black,
              ),
            ),
            Flexible(
              child: IconButton(
                iconSize: 20,
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("ATENÇÃO"),
                      content: Text("Está certo disso?"),
                      actions: [
                        TextButton(
                            child: Text("Não"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                        TextButton(
                            child: Text("Sim"),
                            onPressed: () {
                              deleteJogador(context, jogador);
                              Navigator.of(context).pop();
                            })
                      ],
                    ),
                  );
                },
                color: Colors.black,
              ),
            ),
            Flexible(
              child: IconButton(
                icon: Icon(Icons.sports_esports),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Rotas.TELA_JOGOS,
                    arguments: jogador,
                  );
                },
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
