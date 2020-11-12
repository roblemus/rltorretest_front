import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rltorretest/global.dart';
import 'dart:convert';

class Usuario {
  String usuario, email, enviado;
  Usuario({this.usuario, this.email, this.enviado});
  Map toJson() => {
        'usuario': usuario,
        'email': email,
        'enviado': enviado,
      };
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
        usuario: json['usuario'] as String,
        email: json['email'] as String,
        enviado: json['enviado'] as String);
  }
}

class Usuarios with ChangeNotifier {
  List<Usuario> lUsuarios = [];
  bool isLoading = false;

  Usuarios() {
    lUsuarios = [];
    cargarUsuarios();
  }

  void limpiar() {
    lUsuarios = [];
    notifyListeners();
  }

  void actualizarEmail(String sUsuario, String sNuevoEmail) {
    int nIndice =
        lUsuarios.indexWhere((element) => element.usuario == sUsuario);
    if (nIndice >= 0) lUsuarios[nIndice].email = sNuevoEmail;
    notifyListeners();
  }

  void cargarUsuarios() async {
    isLoading = true;
    //Busqueda de los usuarios en Back End
    try {
      final http.Response rArticulos = await http.get(
        psWeb + 'usuario/getAll',
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        /*body: jsonEncode(<String, dynamic>{
          'idCat': sIdCategoria,
          'descr': sTextoBusqueda,
          'last': sLastId,
        }),*/
      );
      print('Respuesta: ' + rArticulos.body);
      final oParseArticulos =
          json.decode(rArticulos.body).cast<Map<String, dynamic>>();
      List<Usuario> lDatos = oParseArticulos
          .map<Usuario>((json) => Usuario.fromJson(json))
          .toList();
      lUsuarios = lDatos;
    } catch (e) {
      print('Error cargarUsuarios: ' + e.toString());
    }

    isLoading = false;
    notifyListeners();
  }
}
