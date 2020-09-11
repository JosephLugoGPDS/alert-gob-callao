import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:EstoyaTuLado/modelos/noticias.dart';


class ServiciosNoticia {
  ValueNotifier<List<Noticia>> noticias = ValueNotifier(null);
  StreamSubscription _streamSubscription;

  void getNoticias() async {
    _streamSubscription = Firestore.instance.collection('noticias').orderBy("creado", descending: true).snapshots().listen((onData) {
      noticias.value = onData.documents.map((item) {
        final id = item.documentID;
        final data = item.data;
        data['id'] = id;
        return Noticia.fromMap(data);
      }).toList();
    });
  }

  void cancel() {
    _streamSubscription.cancel();
  }
}
