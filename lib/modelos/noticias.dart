import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Noticia {
  final String titulo;
  final String subtitulo;
  final String contenido;
  final String url;
  final String fechaPublicacion;
  final Timestamp creado;
  final String id;

  Noticia({
    @required this.titulo,
    @required this.subtitulo,
    @required this.contenido,
    @required this.url,
    @required this.fechaPublicacion,
    @required this.creado,
    this.id
  });

  factory Noticia.fromMap(dynamic data) => Noticia(
    titulo: data['titulo'],
    subtitulo: data['subtitulo'],
    contenido: data['contenido'],
    url: data['url'],
    fechaPublicacion: data['fechaPublicacion'],
    creado: data['creado'],
    id: data['id']
  );

  Map<String, dynamic> toJson() => {
    'titulo': titulo,
    'subtitulo': subtitulo,
    'contenido': contenido,
    'url': url,
    'fechaPublicacion': fechaPublicacion,
    'creado': creado
  };
}
