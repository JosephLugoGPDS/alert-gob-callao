import 'dart:async';
import 'package:EstoyaTuLado/servicios/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:EstoyaTuLado/modelos/mensajes.dart';

class ServiciosMensaje{
  
  final String uid;
  ServiciosMensaje ({ this.uid });
  
  final CollectionReference mensajeCollection = Firestore.instance.collection('mensajes');
  
  Future mandarMensaje (String idUsuario , String mensaje, String asunto, String nombreUsuario, String telefonoUsuario, String correoUsuario) async {
    return await mensajeCollection.document().setData({
      'idUsuario': idUsuario,
      'contenidoMensaje': mensaje,
      'asuntoMensaje': asunto,
      'nombreUsuario': nombreUsuario,
      'telefonoUsuario': telefonoUsuario,
      'correoUsuario': correoUsuario,
      'fecha': DateTime.now()
    });
  }


  ValueNotifier<List<Mensaje>> mensajes = ValueNotifier(null);
  StreamSubscription _streamSubscription;

  
  void getMensajes() async {
    // OBTENER ID DEL CURRENT USER
    final AuthService _auth = AuthService();
    FirebaseUser user;
    user = await _auth.getCurrentUser();
    final idUsuario = user.uid;
    //
    _streamSubscription = Firestore.instance.collection('mensajes').where( "idUsuario",isEqualTo: idUsuario).snapshots().listen((onData) {
      mensajes.value = onData.documents.map((item) {
        final id = item.documentID;
        final data = item.data;
        data['id'] = id;
        return Mensaje.fromMap(data);
      }).toList();
    });

  }

  void cancel() {
    _streamSubscription.cancel();
  }



}