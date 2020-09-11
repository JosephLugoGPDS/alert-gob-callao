import 'package:meta/meta.dart';

class Contacto {
  final String idUsuario;
  final String nombreContacto;
  final String telefonoContacto;
  final String correoContacto;
  final String id;

  Contacto({
    @required this.idUsuario,
    @required this.nombreContacto,
    @required this.telefonoContacto,
    @required this.correoContacto,
    this.id
  });

  factory Contacto.fromMap(dynamic data) => Contacto(
    idUsuario: data['idUsuario'],
    nombreContacto: data['nombreContacto'],
    telefonoContacto: data['telefonoContacto'],
    correoContacto: data['correoContacto'],
    id: data['id'],
  );

  Map<String, dynamic> toJson() => {
    'idUsuario': idUsuario,
    'nombreContacto': nombreContacto,
    'telefonoContacto': telefonoContacto,
    'correoContacto': correoContacto,
  };
}
