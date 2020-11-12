import 'package:http/http.dart' as http;
import 'dart:convert';

String psWeb = "http://rltorretest.tiendaseuz4.com/api/public/";
String psTorre = "https://torre.bio/api/bios/";
String psEslogan = "Robertos sin SIGNLAS";

class Logged {
  Persona persona;
  Estadistica estadistica;
  Logged({this.persona, this.estadistica});
  factory Logged.fromJson(Map<String, dynamic> parsedJson) {
    try {
      return Logged(
          persona: Persona.fromJson(parsedJson['person']),
          estadistica: Estadistica.fromJson(parsedJson['stats']));
    } catch (e) {
      print("Error: $e");
      return Logged();
    }
  }
  factory Logged.usuarioInicial(String sUsuario) {
    /*Persona oPersona = Persona();
    oPersona.nombre = "";
    oPersona.profesion = "";
    oPersona.fecha = "";
    oPersona.imagen = "";
    Estadistica oEstadistica = Estadistica();
    oEstadistica.trabajo = "";
    oEstadistica.educacion = "";
    oEstadistica.habilidades = "";
    oEstadistica.intereses = "";
    pLogged = Logged();
    pLogged.persona = oPersona;
    pLogged.estadistica = oEstadistica;*/
    fetchUsuario(sUsuario);
    return pLogged;
  }
}

Future<Logged> fetchUsuario(String sUsuario) async {
  final response = await http.get(psTorre + sUsuario);
  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    String sMensaje = response.body;
    Map<String, dynamic> user = jsonDecode(sMensaje);
    if (sMensaje.contains("error")) {
    } else {
      return Logged.fromJson(user);
    }
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    print('Failed to load post');
  }
}

class Persona {
  String nombre, profesion, fecha, imagen;
  Persona({this.nombre, this.profesion, this.fecha, this.imagen});
  factory Persona.fromJson(Map<String, dynamic> parsedJson) {
    return Persona(
        nombre: parsedJson['name'] as String,
        profesion: parsedJson['professionalHeadline'] as String,
        fecha: parsedJson['created'] as String,
        imagen: parsedJson['picture'] as String);
  }
}

class Estadistica {
  String trabajo, educacion, habilidades, intereses;
  Estadistica({this.trabajo, this.educacion, this.habilidades, this.intereses});
  factory Estadistica.fromJson(Map<String, dynamic> parsedJson) {
    return Estadistica(
        trabajo: parsedJson[0] as String,
        educacion: parsedJson[1] as String,
        habilidades: parsedJson[2] as String,
        intereses: parsedJson[3] as String);
  }
}

Logged pLogged = Logged();
