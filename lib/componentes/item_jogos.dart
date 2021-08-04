import 'package:flutter/material.dart';
import '../models/jogos.dart';
import '../providers/jogos_providers.dart';
import '../utils/rotas.dart';
import 'package:provider/provider.dart';

class ItemListaJogos extends StatelessWidget {
  final Jogos jogo;

  ItemListaJogos(this.jogo);

  void deleteJogo(context, Jogos jogo) {
    Provider.of<JogosProvider>(context, listen: false).deleteJogo(jogo);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      tileColor: Colors.yellow[400],
      title: Container(
        child: Text(
          jogo.dataJogo,
          style: TextStyle(color: Colors.black),
        ),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.green),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  Rotas.EDIT_JOGOS,
                  arguments: jogo,
                );
              },
              color: Colors.black,
            ),
            IconButton(
              iconSize: 20,
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
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
                            deleteJogo(context, jogo);
                            Navigator.of(context).pop();
                          })
                    ],
                  ),
                );
              },
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
