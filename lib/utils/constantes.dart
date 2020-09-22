import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  errorStyle: TextStyle(color: kSecondaryColor),
  
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width:2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColorDark, width: 2.0),
  ),
  
);

//pink #ce2870
// const kPrimaryColor = Color.fromRGBO(206, 40, 112, 1.0);
//purple final #876aad
const kPrimaryColor = Color.fromRGBO(135, 106, 173, 1.0);
//purple final #6f2c8d
const kPrimaryColorDark = Color.fromRGBO(111, 44, 141, 1.0);

const kSecondaryColor = Colors.white;
const kSecondaryColor10 = Colors.white10;

