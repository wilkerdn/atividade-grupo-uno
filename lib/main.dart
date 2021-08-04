import 'package:flutter/material.dart';
import 'telas/tela_auth_ou_home.dart';
import 'telas/tela_edit_jogos.dart';
import 'telas/tela_login.dart';
import 'telas/tela_form_jogadores.dart';
import 'providers/jogadores_providers.dart';
import 'providers/jogos_providers.dart';
import 'providers/login.dart';
import 'telas/tela_jogadores.dart';
import 'telas/tela_jogos.dart';
import 'telas/tela_form_jogos.dart';
import 'utils/rotas.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Login(),
        ),
        ChangeNotifierProxyProvider<Login, JogadorProvider>(
          create: (ctx) => JogadorProvider('', []),
          update: (ctx, login, jogador) =>
              JogadorProvider(login.token, jogador.getJogador),
        ),
        ChangeNotifierProvider(
          create: (ctx) => JogosProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {
          Rotas.AUTH: (ctx) => TelaEscolheHome(),
          Rotas.HOME: (ctx) => TelaJogadores(),
          Rotas.FORM_JOGADOR: (ctx) => TelaFormJogador(),
          Rotas.TELA_JOGOS: (ctx) => TelaJogos(),
          Rotas.FORM_JOGOS: (ctx) => TelaFormJogos(),
          Rotas.EDIT_JOGOS: (ctx) => TelaEditJogos(),
        },
        onGenerateRoute: (settings) {
          print(settings.name);
          return null;
        },
        onUnknownRoute: (settings) {
          print("Rota não encontrada");
          return null;
        },
      ),
    );
  }
}
