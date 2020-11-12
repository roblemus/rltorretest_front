import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rltorretest/models/usuarios.dart';
import 'package:rltorretest/models/usuariosenviar.dart';
import 'package:rltorretest/screens/envios.dart';
import 'package:rltorretest/screens/principal.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Usuarios()),
          ChangeNotifierProvider(create: (_) => UsuariosEnviar()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RL Torre Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'OpenSans',
      ),
      home: Principal(),
      routes: {
        'listado': (context) => Principal(),
        'envios': (context) => ListaUsuariosEnviar(),
      },
    );
  }
}
