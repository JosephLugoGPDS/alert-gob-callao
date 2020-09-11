import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:EstoyaTuLado/modelos/localizacion.dart';
//
import 'package:EstoyaTuLado/servicios/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ServiciosAlerta{
  
  final String uid;
  ServiciosAlerta ({ this.uid });

  ValueNotifier<List<Localizacion>> alertas = ValueNotifier(null);
  StreamSubscription _streamSubscription;
  
  // Referencia de la coleccion
  final CollectionReference locacionCollection = Firestore.instance.collection('localizacion');
  
  Future enviarAlerta (String idUsuario , double latitud , double longitud , String problema, String nombreUsuario, String telefonoUsuario) async {
    return await locacionCollection.document().setData({
      'idUsuario': idUsuario,
      'userPosition': new GeoPoint(latitud, longitud),
      'problema': problema,
      'nombreUsuario': nombreUsuario,
      'telefonoUsuario':telefonoUsuario,
      'fecha': DateTime.now()
    });
  }


  void getLocalizacion() async {
    // OBTENER ID DEL CURRENT USER
    final AuthService _auth = AuthService();
    FirebaseUser user;
    user = await _auth.getCurrentUser();
    final idUsuario = user.uid;
    //
    _streamSubscription = Firestore.instance.collection('localizacion').where( "idUsuario",isEqualTo: idUsuario).snapshots().listen((onData) {
      alertas.value = onData.documents.map((item) {
        final id = item.documentID;
        final data = item.data;
        data['id'] = id;
        return Localizacion.fromMap(data);
      }).toList();
    });
  }

  void cancel() {
    _streamSubscription.cancel();
  }

}