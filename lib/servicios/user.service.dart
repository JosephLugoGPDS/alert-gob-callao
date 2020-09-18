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


  Future<UserMoreInfo> agregarInformacion(UserMoreInfo informacion) async {
    final url = '$_url/usuarios/${informacion.id}';
    

    final res = await http.get( '$url/email.json');

    informacion.email = json.decode(res.body);

    final res2 = await http.get( '$url/celular.json');

    informacion.celular = json.decode(res2.body);


    return informacion;
  }

  Future<UserMoreInfo> cargarInformacion(UserMoreInfo informacion) async {

    final url = '$_url/usuarios/${informacion.id}';
    

    final res = await http.get( '$url/email.json');

    informacion.email = json.decode(res.body);

    final res2 = await http.get( '$url/celular.json');

    informacion.celular = json.decode(res2.body);

    final res3 = await http.get( '$url/nombre.json');

    informacion.nombre = json.decode(res3.body);

    final res4 = await http.get( '$url/apellido.json');

    informacion.apellido = json.decode(res4.body);

    final res5 = await http.get( '$url/fijo.json');

    informacion.fijo = json.decode(res5.body);

    final res6 = await http.get( '$url/dni.json');

    informacion.dni = json.decode(res6.body);


    return informacion;
  }
  Future<UserMoreInfo> cargarInformacion2(UserMoreInfo informacion) async {
    

    final url = '$_url/usuarios/${informacion.id}';
    

    final res = await http.get( '$url/email.json');

    informacion.email = json.decode(res.body);

    final res2 = await http.get( '$url/celular.json');

    informacion.celular = json.decode(res2.body);

    final res3 = await http.get( '$url/nombre.json');

    informacion.nombre = json.decode(res3.body);

    final res4 = await http.get( '$url/apellido.json');

    informacion.apellido = json.decode(res4.body);

    final res5 = await http.get( '$url/fijo.json');

    informacion.fijo = json.decode(res5.body);

    final res6 = await http.get( '$url/dni.json');

    informacion.dni = json.decode(res6.body);

    final res7 = await http.get( '$url/distrito.json');

    informacion.distrito = json.decode(res7.body);

    final res8 = await http.get( '$url/direccion%20.json');

    informacion.direccion = json.decode(res8.body);

    final res9 = await http.get( '$url/fecha.json');

    informacion.fecha = json.decode(res9.body);

    return informacion;
  }

  Future<UserMoreInfo> fullInformacion(UserMoreInfo informacion) async {
    
    final res = await http.get('https://alert-test-b54e0.firebaseio.com/usuarios/${informacion.id}.json');


    final Map<String,dynamic> decodeData = json.decode(res.body);

    informacion = UserMoreInfo.fromJson(decodeData);

    return informacion;
  }

  


}