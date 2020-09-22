import 'dart:convert';

import 'package:EstoyaTuLado/modelos/userinfo.dart';
import 'package:EstoyaTuLado/servicios/auth.dart';
import 'package:http/http.dart' as http;

final AuthService auth = AuthService();
class UserInfoProvider {

  final String _url = 'https://alert-test-b54e0.firebaseio.com';


  Future<bool> actualizarInformacion(UserMoreInfo informacion) async {
    final url = '$_url/usuarios/${informacion.id}.json';

    final res = await http.put( url, body: userMoreInfoToJson(informacion));

    final decodedData = json.decode(res.body);

    print(decodedData);

    return true;

  }



Future<UserMoreInfo> getInformacion(String id) async {
    final url = '$_url/usuarios/$id.json';

    final res = await http.get(url);

    final Map<String,dynamic> decodedData = json.decode(res.body);
    final info = UserMoreInfo.fromJson(decodedData);
    // final resAux = await http.get( '$url/direccion%

    print(info);

    return info;

  }
  


}