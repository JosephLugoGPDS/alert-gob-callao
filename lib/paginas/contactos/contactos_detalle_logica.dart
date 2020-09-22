import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:EstoyaTuLado/modelos/contactos.dart';
import 'package:EstoyaTuLado/utils/debouncer.dart';

import 'package:EstoyaTuLado/utils/capitalizar.dart';
class LogicaDetalles {

  LogicaDetalles(this.contacto);

  final Contacto contacto;

  final textControllerNombre = TextEditingController();
  final textControllerCorreo = TextEditingController();
  final textControllerTelefono = TextEditingController();

  ValueNotifier<bool> valid = ValueNotifier(false);
  final debouncer = Debouncer();

  void init() {
    if (contacto != null) {
      textControllerNombre.text = contacto.nombreContacto;
      textControllerCorreo.text = contacto.correoContacto;
      textControllerTelefono.text = contacto.telefonoContacto;
      valid.value = true;
    }
  }

  void save(String dato) async {
    final idUsuario = dato;
    final nombreContacto = textControllerNombre.text.trim().capitalize();
    final correoContacto = textControllerCorreo.text.trim().toLowerCase();
    final telefonoContacto = textControllerTelefono.text.trim();

    final localContacto = Contacto(idUsuario: idUsuario,nombreContacto: nombreContacto, correoContacto: correoContacto, telefonoContacto: telefonoContacto);
    final ref = Firestore.instance.collection('contactos');
    if (contacto != null) {
      ref.document(contacto.id).updateData(
            localContacto.toJson(),
      );
    } else {
      ref.add(
        localContacto.toJson(),
      );
    }
  }

  void delete() {
    Firestore.instance.collection('contactos').document(contacto.id).delete();
  }

  void onNombreChanged(String val) {
    debouncer.run(() async {
      // final nombreContacto = val.trim().toLowerCase();
      final nombreContacto = val.trim().capitalize();
      valid.value = null;
      if (nombreContacto.isNotEmpty) {
        final query = Firestore.instance
            .collection('contactos')
            .where(
              'nombreContacto',
              isEqualTo: nombreContacto,
            )
            .limit(1);

        final list = await query.getDocuments();
        if (contacto != null) {
          if (list.documents.isNotEmpty) {
            final docID = list.documents.first.documentID;
            valid.value = docID == contacto.id;
          }
        } else {
          valid.value = !(list.documents.length > 0);
        }
      } else {
        valid.value = false;
      }
    });
  }
}