import 'dart:convert';

import 'package:EstoyaTuLado/modelos/userinfo.dart';
import 'package:http/http.dart' as http;


class UserInfoProvider {

  final String _url = 'https://alert-test-b54e0.firebaseio.com';


  Future<bool> actualizarInformacion(UserMoreInfo informacion) async {
    final url = '$_url/usuarios/${informacion.id}.json';

    final res = await http.put( url, body: userMoreInfoToJson(informacion));

    final decodedData = json.decode(res.body);

    print(decodedData);

    return true;

  }


  Future<bool> agregarInformacion(UserMoreInfo informacion) async {
    final url = '$_url/usuarios/${informacion.id}.json';
    // final url = '$_url/usuarios.json';

    final res = await http.put( url, body: userMoreInfoToJson(informacion));

    final decodedData = json.decode(res.body);

    print(decodedData);

    return true;
  }

  Future<UserMoreInfo> cargarInformacion(UserMoreInfo informacion) async {
    
    final temp = await http.get('https://alert-test-b54e0.firebaseio.com/usuarios/${informacion.id}/apellido.json');

    informacion.apellido = json.decode(temp.body);

    final temp2 = await http.get('https://alert-test-b54e0.firebaseio.com/usuarios/${informacion.id}/nombre.json');

    informacion.nombre = json.decode(temp2.body);

    final temp3 = await http.get('https://alert-test-b54e0.firebaseio.com/usuarios/${informacion.id}/fijo.json');

    informacion.fijo = json.decode(temp3.body);
    
    final temp4 = await http.get('https://alert-test-b54e0.firebaseio.com/usuarios/${informacion.id}/dni.json');

    informacion.dni = json.decode(temp4.body);

    return informacion;
  }
  Future<UserMoreInfo> cargarInformacion2(UserMoreInfo informacion) async {
    
    final temp2 = await http.get('https://alert-test-b54e0.firebaseio.com/usuarios/${informacion.id}/nombre.json');

    informacion.nombre = json.decode(temp2.body);

    final temp = await http.get('https://alert-test-b54e0.firebaseio.com/usuarios/${informacion.id}/apellido.json');

    informacion.apellido = json.decode(temp.body);

    final temp3 = await http.get('https://alert-test-b54e0.firebaseio.com/usuarios/${informacion.id}/fijo.json');

    informacion.fijo = json.decode(temp3.body);
    
    final temp4 = await http.get('https://alert-test-b54e0.firebaseio.com/usuarios/${informacion.id}/dni.json');

    informacion.dni = json.decode(temp4.body);

    final tem5 = await http.get('https://alert-test-b54e0.firebaseio.com/usuarios/${informacion.id}/distrito.json');

    informacion.distrito = json.decode(tem5.body);
    
    final temp6 = await http.get('https://alert-test-b54e0.firebaseio.com/usuarios/${informacion.id}/direccion%20.json');

    informacion.direccion = json.decode(temp6.body);

    return informacion;
  }

  Future<UserMoreInfo> fullInformacion(UserMoreInfo informacion) async {
    
    final res = await http.get('https://alert-test-b54e0.firebaseio.com/usuarios/${informacion.id}.json');


    final Map<String,dynamic> decodeData = json.decode(res.body);

    informacion = UserMoreInfo.fromJson(decodeData);

    return informacion;
  }

  


}