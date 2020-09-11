import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Localizacion {
  final String idUsuario;
  final String nombreUsuario;
  final String telefonoUsuario;
  final GeoPoint userPosition;
  final String problema;
  final Timestamp fecha;
  final String id;

  Localizacion({
    @required this.idUsuario,
    @required this.nombreUsuario,
    @required this.telefonoUsuario,
    @required this.userPosition,
    @required this.problema,
    @required this.fecha,
    this.id
  });

  factory Localizacion.fromMap(dynamic data) => Localizacion(
    idUsuario: data['idUsuario'],
    nombreUsuario: data['nombreUsuario'],
    telefonoUsuario: data['telefonoUsuario'],
    userPosition: data['userPosition'],
    problema: data['problema'],
    fecha: data['fecha'],
    id: data['id'],
  );

  Map<String, dynamic> toJson() => {
    'idUsuario': idUsuario,
    'nombreUsuario': nombreUsuario,
    'telefonoUsuario': telefonoUsuario,
    'userPosition': userPosition,
    'problema': problema,
    'fecha': fecha,
  };
}

