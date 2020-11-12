import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rltorretest/models/usuariosenviar.dart';
import 'package:http/http.dart' as http;
import 'package:rltorretest/global.dart';
import 'dart:convert';

class ListaUsuariosEnviar extends StatelessWidget {
  String sRespuesta = "";

  void mostrarDialogo(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Resultado"),
          content: new Text("$sRespuesta"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.pushNamed(context, 'listado');
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> enviarEmails(BuildContext context) async {
    try {
      var oEnviar = context.read<UsuariosEnviar>();
      if (oEnviar.lUsuariosEnviar.length <= 0) {
        Navigator.pushNamed(context, 'listado');
        return;
      }
      for (var i = 0; i < oEnviar.lUsuariosEnviar.length; i++) {
        final http.Response oRespuesta = await http.post(
          psWeb + 'usuario/sendEmail',
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            'sEmail': oEnviar.lUsuariosEnviar[i].email,
            'sUsuario': oEnviar.lUsuariosEnviar[i].usuario
          }),
        );
        String sMensaje = oRespuesta.body;
        if (sMensaje.contains("false")) {
          sRespuesta = 'No se envío';
        } else {
          sRespuesta = "Enviado";
        }
      }
    } catch (e) {
      sRespuesta = e.error;
    }
    sRespuesta = "Email enviados";
    mostrarDialogo(context);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mqdMedia = MediaQuery.of(context);
    final double nAncho = mqdMedia.size.width;
    return Consumer<UsuariosEnviar>(
        builder: (context, lEnviar, c) => Scaffold(
              backgroundColor: Colors.lightBlue[50],
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.lightBlue,
                title: Text(
                  "Motivar a Robertos",
                  style: Theme.of(context).textTheme.headline6.apply(
                        color: Colors.white,
                      ),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 5.0,
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: lEnviar.lUsuariosEnviar.length,
                                padding: EdgeInsets.all(2.0),
                                itemBuilder: (BuildContext context, int i) {
                                  return ListTile(
                                    title: Text(
                                        "${lEnviar.lUsuariosEnviar[i].usuario}"),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5.0,
                                      ),
                                    ),
                                    trailing: Text(
                                        "${lEnviar.lUsuariosEnviar[i].email}"),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text(
                              "Enviar Email ",
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .apply(color: Colors.white),
                            ),
                            onPressed: () => {enviarEmails(context)},
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
