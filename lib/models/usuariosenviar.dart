import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rltorretest/global.dart';
import 'dart:convert';

class UsuarioEnviar {
  String usuario, email, enviado;
  UsuarioEnviar({this.usuario, this.email, this.enviado});
  Map toJson() => {
        'usuario': usuario,
        'email': email,
        'enviado': enviado,
      };
  factory UsuarioEnviar.fromJson(Map<String, dynamic> json) {
    return UsuarioEnviar(
        usuario: json['usuario'] as String,
        email: json['email'] as String,
        enviado: json['enviado'] as String);
  }
}

class UsuariosEnviar with ChangeNotifier {
  List<UsuarioEnviar> lUsuariosEnviar = [];
  bool isLoading = false;

  UsuariosEnviar() {
    lUsuariosEnviar = [];
    cargarUsuariosEnviar();
  }

  void limpiar() {
    lUsuariosEnviar = [];
    notifyListeners();
  }

  void cargarUsuariosEnviar() async {
    isLoading = true;
    //Busqueda de los usuarios en Back End
    try {
      final http.Response rArticulos = await http.get(
        psWeb + 'usuario/getSend',
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      print('Respuesta: ' + rArticulos.body);
      final oParseArticulos =
          json.decode(rArticulos.body).cast<Map<String, dynamic>>();
      List<UsuarioEnviar> lDatos = oParseArticulos
          .map<UsuarioEnviar>((json) => UsuarioEnviar.fromJson(json))
          .toList();
      lUsuariosEnviar = lDatos;
    } catch (e) {
      print('Error cargarUsuariosEnviar: ' + e.toString());
    }

    isLoading = false;
    notifyListeners();
  }
}
