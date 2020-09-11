import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Mensaje {
  final String idUsuario;
  final String nombreUsuario;
  final String asuntoMensaje;
  final String contenidoMensaje;
  final Timestamp fecha;
  final String id;

  Mensaje({
    @required this.idUsuario,
    @required this.nombreUsuario,
    @required this.asuntoMensaje,
    @required this.contenidoMensaje,
    @required this.fecha,
    this.id
  });

  factory Mensaje.fromMap(dynamic data) => Mensaje(
    idUsuario: data['idUsuario'],
    nombreUsuario: data['nombreUsuario'],
    asuntoMensaje: data['asuntoMensaje'],
    contenidoMensaje: data['contenidoMensaje'],
    fecha: data['fecha'],
    id: data['id'],
  );

  Map<String, dynamic> toJson() => {
    'idUsuario': idUsuario,
    'nombreUsuario': nombreUsuario,
    'asuntoMensaje': asuntoMensaje,
    'contenidoMensaje': contenidoMensaje,
    'fecha': fecha,
  };
}