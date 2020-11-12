import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rltorretest/global.dart';
import 'package:rltorretest/models/lista.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  Future<void> _logoutUsuario(BuildContext context) async {
    try {
      final http.Response oRespuesta = await http.post(
        psWeb + 'auth/logout',
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (oRespuesta.statusCode == 200 || oRespuesta.statusCode == 201) {
        String sMensaje = oRespuesta.body;
        if (sMensaje.contains("error")) {
        } else {
          Navigator.pushNamed(context, 'loginscreen');
        }
      } else {}
    } catch (e) {
      print('Error agregarItem: ' + e.toString());
    }
  }

  Widget getAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black54),
      backgroundColor: Colors.lightBlue,
      elevation: 0.0,
      title: Text(
        psEslogan,
        style: Theme.of(context).textTheme.headline6.apply(
              color: Colors.white,
            ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String sUsuario = "Bienvenido a RL Torre Test";
    final drawerHeader = UserAccountsDrawerHeader(
      accountEmail: Text("Torre.co",
          style: Theme.of(context).textTheme.headline5.apply(
                color: Colors.white,
              )),
      accountName: Text(sUsuario,
          style: Theme.of(context).textTheme.headline6.apply(
                color: Colors.white,
              )),
      currentAccountPicture: CircleAvatar(
        child: Image.asset(
          'img/TORRE.jpg',
          fit: BoxFit.fill,
          width: 500,
        ),
      ),
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          leading: Icon(Icons.calendar_view_day_outlined),
          title: Text('Listado de Robertos'),
          onTap: () => Navigator.pushNamed(context, 'listado'),
        ),
        ListTile(
          leading: Icon(Icons.security_outlined),
          title: Text('Enviar Email de Motivación'),
          onTap: () => Navigator.pushNamed(context, 'envios'),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      drawer: Drawer(
        child: drawerItems,
      ),
      appBar: getAppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              ListaUsuarios(),
            ],
          ),
        ),
      ),
    );
  }
}
