import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:rltorretest/models/usuarios.dart';

class Listado extends StatelessWidget {
  final String sRespuesta = "";

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mqdMedia = MediaQuery.of(context);
    final double nAncho = mqdMedia.size.width;
    return Consumer<Usuarios>(
        builder: (context, usuarios, c) => Scaffold(
              backgroundColor: Colors.lightBlue[50],
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.lightBlue,
                title: Text(
                  "Robertos sin SIGNALS",
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
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => {},
                  )
                ],
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
                                itemCount: usuarios.lUsuarios.length,
                                padding: EdgeInsets.all(2.0),
                                itemBuilder: (BuildContext context, int i) {
                                  return ListTile(
                                    /*leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Image.memory(
                                        base64Decode(usuarios.lUsuarios[i].img),
                                        width: 70,
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),*/
                                    title: Text(
                                        "${usuarios.lUsuarios[i].usuario}"),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5.0,
                                      ),
                                    ),
                                    trailing:
                                        Text("${usuarios.lUsuarios[i].email}"),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
