import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width:2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
  
);

//pink #ce2870
// const kPrimaryColor = Color.fromRGBO(206, 40, 112, 1.0);
const kPrimaryColorAux = Color.fromRGBO(234,65,136,1.0);//algunos colores
//purple #73045c
const kPrimaryColor = Color.fromRGBO(115, 4, 92, 1.0);
// const kPrimaryColor = Color.fromRGBO(136, 39, 118, 1.0);

const kSecondaryColor = Colors.white;
const kSecondaryColor10 = Colors.white10;