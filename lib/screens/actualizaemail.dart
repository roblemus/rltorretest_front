import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rltorretest/global.dart';
import 'package:rltorretest/models/usuarios.dart';
import 'package:provider/provider.dart';

class ActualizarEmail extends StatefulWidget {
  final Usuario oUser;
  const ActualizarEmail({Key key, this.oUser}) : super(key: key);
  @override
  _ActualizarEmailState createState() => _ActualizarEmailState();
}

class _ActualizarEmailState extends State<ActualizarEmail> {
  String sRespuesta;
  String sEmail;
  bool bPendiente;
  TextEditingController txtEmail;
  @override
  void initState() {
    super.initState();
    sRespuesta = "";
    sEmail = widget.oUser.email;
    txtEmail = TextEditingController();
    txtEmail.text = sEmail;
    bPendiente = false;
  }

  Future<void> actualizarEmail(BuildContext context) async {
    try {
      final http.Response oRespuesta = await http.post(
        psWeb + 'usuario/updateEmail',
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'sEmail': sEmail,
          'sUsuario': widget.oUser.usuario
        }),
      );
      var oUsuarios = context.read<Usuarios>();
      oUsuarios.actualizarEmail(widget.oUser.usuario, sEmail);

      Navigator.pushNamed(context, 'listado');
    } catch (e) {
      sRespuesta = e.error;
    }
  }

  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(context) => Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Registrate",
          style: Theme.of(context).textTheme.headline6.apply(
                color: Colors.white,
              ),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 500),
          padding: constraints.maxWidth < 500
              ? EdgeInsets.zero
              : const EdgeInsets.all(30.0),
          child: Center(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
              constraints: BoxConstraints(
                maxWidth: 500,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  children: <Widget>[
                    TextFormField(
                      controller: txtEmail,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.email),
                        hintText: 'email@email.com',
                        labelText: 'Email',
                      ),
                      maxLength: 40,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Ingrese el email';
                        }
                      },
                      onSaved: (val) => setState(() => sEmail = val),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Enviar'),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            this.actualizarEmail(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }));
}
