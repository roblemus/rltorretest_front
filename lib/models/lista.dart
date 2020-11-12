import 'package:flutter/material.dart';
import 'package:rltorretest/models/usuarios.dart';
import 'package:provider/provider.dart';
import 'package:rltorretest/screens/usuario.dart';

class ListaUsuarios extends StatefulWidget {
  @override
  _ListaUsuariosState createState() => _ListaUsuariosState();
}

class _ListaUsuariosState extends State<ListaUsuarios> {
  Widget _getListItemTile(BuildContext context, int index, Usuario usuario) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetalleUsuario(oUser: usuario)),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            child: Text('$index'),
          ),
          title: Text("${usuario.usuario}"),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
          ),
          trailing: Text("${usuario.email}"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mqdMedia = MediaQuery.of(context);
    final double nAncho = mqdMedia.size.width;
    return Center(
      child: Consumer<Usuarios>(
          builder: (BuildContext context, Usuarios value, Widget child) {
        if (value.lUsuarios.length > 0) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: value.isLoading
                  ? value.lUsuarios.length + 1
                  : value.lUsuarios.length,
              itemBuilder: (BuildContext context, int index) {
                if (value.lUsuarios.length == 0) {
                  return Center(
                    child: Text("No hay registros"),
                  );
                }
                if (index >= value.lUsuarios.length) {
                  return Center(child: CircularProgressIndicator());
                }
                return _getListItemTile(context, index, value.lUsuarios[index]);
              });
        } else
          return Center(child: CircularProgressIndicator());
      }),
    );
  }
}
