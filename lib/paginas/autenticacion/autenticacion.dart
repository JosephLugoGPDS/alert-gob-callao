import 'package:flutter/material.dart';
import 'package:EstoyaTuLado/paginas/autenticacion/login.dart';
import 'package:EstoyaTuLado/paginas/autenticacion/registro.dart';


class Autenticacion extends StatefulWidget {
  
  @override
  _AutenticacionState createState() => _AutenticacionState();
}

class _AutenticacionState extends State<Autenticacion> {

  bool mostrarLogin = true;

  void  toggleView(){
    setState(() => mostrarLogin = !mostrarLogin);
  }

  @override
  Widget build(BuildContext context) {
    if(mostrarLogin){
      return Login(toggleView : toggleView);
    }else{
      return Registro(toggleView : toggleView);
    }
  }
}