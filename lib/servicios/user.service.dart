import 'dart:convert';

import 'package:EstoyaTuLado/modelos/userinfo.dart';
import 'package:http/http.dart' as http;


class UserInfoProvider {

  final String _url = 'https://alert-test-b54e0.firebaseio.com';


  Future<bool> actualizarInformacion(UserMoreInfo informacion) async {
    final url = '$_url/usuarios.json';

    final res = await http.post( url, body: userMoreInfoToJson(informacion));

    final decodedData = json.decode(res.body);

    print(decodedData);

    return true;

  }


  Future<bool> agregarInformacion(UserMoreInfo informacion) async {
    final url = '$_url/usuarios/${informacion.id}.json';

    final res = await http.put( url, body: userMoreInfoToJson(informacion));

    final decodedData = json.decode(res.body);

    print(decodedData);

    return true;
  }


}