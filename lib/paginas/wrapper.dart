import 'package:flutter/material.dart';
import 'package:EstoyaTuLado/paginas/autenticacion/autenticacion.dart';
import 'package:EstoyaTuLado/paginas/home/home_page.dart';
import 'package:provider/provider.dart';
import 'package:EstoyaTuLado/modelos/usuario.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    
    // Regresar Home o Autenticacion Widget
    if(user == null){
      return Autenticacion();
    }else{
      return Home();
    }
  }
}