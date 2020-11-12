import 'package:flutter/material.dart';
import 'package:rltorretest/models/usuarios.dart';
import 'package:rltorretest/global.dart';
import 'package:rltorretest/screens/actualizaemail.dart';

class DetalleUsuario extends StatefulWidget {
  final Usuario oUser;

  const DetalleUsuario({Key key, this.oUser}) : super(key: key);

  @override
  _DetalleUsuarioState createState() => _DetalleUsuarioState();
}

class _DetalleUsuarioState extends State<DetalleUsuario> {
  @override
  void initState() {
    super.initState();
  }

  void _actualizar(Usuario xUsuario) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ActualizarEmail(oUser: xUsuario)));
  }

  Widget _buildDetail() {
    final Future<Logged> xLogged = fetchUsuario(widget.oUser.usuario);
    return Center(
      child: FutureBuilder<Logged>(
        future: xLogged,
        builder: (context, snapshot) {
          pLogged = snapshot.data;
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.chevron_left,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: (pLogged.persona.imagen != null)
                              ? FadeInImage.assetNetwork(
                                  image: pLogged.persona.imagen,
                                  placeholder: "assets/img/TORRE.jpg")
                              : Image.asset("assets/img/TORRE.jpg"),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "${widget.oUser.usuario}",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Nombre: "),
                            Text("${pLogged.persona.nombre}"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Profesion: "),
                            Text("${pLogged.persona.profesion}"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Desde: "),
                            Text("${pLogged.persona.fecha}"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Est: "),
                            Text(
                                "Trabajos => ${pLogged.estadistica.trabajo}, Intereses => ${pLogged.estadistica.intereses}"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Est: "),
                            Text(
                                "Educación => ${pLogged.estadistica.educacion}, Habilidades => ${pLogged.estadistica.habilidades}"),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text(
                              "Actualizar Email",
                              style: Theme.of(context).textTheme.button.apply(
                                    color: Colors.white,
                                  ),
                            ),
                            onPressed: () => _actualizar(widget.oUser),
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // Por defecto, muestra un loading spinner
          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _buildDetail(),
      ),
    );
  }
}
