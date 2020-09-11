import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:EstoyaTuLado/modelos/contactos.dart';

import 'package:EstoyaTuLado/servicios/auth.dart';



class ServiciosContactos {
  ValueNotifier<List<Contacto>> contactos = ValueNotifier(null);
  StreamSubscription _streamSubscription;

  
  void getContactos() async {
    // OBTENER ID DEL CURRENT USER
    final AuthService _auth = AuthService();
    FirebaseUser user;
    user = await _auth.getCurrentUser();
    final idUsuario = user.uid;
    //
    _streamSubscription = Firestore.instance.collection('contactos').where("idUsuario",isEqualTo: idUsuario).snapshots().listen((onData) {
      contactos.value = onData.documents.map((item) {
        final id = item.documentID;
        final data = item.data;
        data['id'] = id;
        return Contacto.fromMap(data);
      }).toList();
    });
  }

  void cancel() {
    _streamSubscription.cancel();
  }
}