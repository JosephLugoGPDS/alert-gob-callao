import 'package:EstoyaTuLado/paginas/cuenta/lista_alertas.dart';
import 'package:EstoyaTuLado/paginas/cuenta/lista_mensajes.dart';
import 'package:EstoyaTuLado/utils/constantes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:EstoyaTuLado/servicios/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'completar_perfil.dart';


class Configuracion extends StatefulWidget {
  @override
  _ConfiguracionState createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {

  final AuthService auth = AuthService();
  FirebaseUser user;

  cerrarSesion(BuildContext context){

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("¿Desea cerrar sesión?"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          actions: <Widget>[
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width/4,
              height: 40,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: kPrimaryColor)
                ),
                color: kPrimaryColor,
                child: Text('Si', style: TextStyle(color: Colors.white,fontSize: 20)),
                onPressed: () async {
                  //ToDo: Arreglar 
                  await auth.signOut();
                  Navigator.of(context).pop();
                },
              ),
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width/4,
              height: 40,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: kPrimaryColor)
                ),
                color: kPrimaryColor,
                child: Text('No', style: TextStyle(color: Colors.white,fontSize: 20)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Mi Cuenta",
              style: TextStyle(fontSize: 22, color: Colors.white),
            )
          ],
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: auth.getCurrentUser(),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  return displayUserInformation(context,snapshot);
                }else{
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget displayUserInformation(context,snapshot){
    final user = snapshot.data; 
    return Column(
      children: <Widget>[
        Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 40),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.only(top: 30),
                        child: Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: kPrimaryColorDark,
                              child: Text(
                                "${user.displayName}".substring(0,1).toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50
                                ),  
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${user.displayName}",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600
                        )
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${user.email}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${user.photoUrl}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(width: 30),
              ],
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CompletarPerfil()),
                );
              },
              child: Container(
                height: 55.0,
                margin: EdgeInsets.symmetric(
                  horizontal: 40
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kPrimaryColorDark,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add,size: 25,color: Colors.white),
                    SizedBox(width: 15),
                    Text(
                      "Completar perfil",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      )
                    ),
                    Spacer(),
                    FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: 25,
                      color: Colors.white54,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaAlertas()),
                );
              },
              child: Container(
                height: 55.0,
                margin: EdgeInsets.symmetric(
                  horizontal: 40
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kPrimaryColorDark,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.priority_high,size: 25,color: Colors.white),
                    SizedBox(width: 15),
                    Text(
                      "Alertas Enviadas",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      )
                    ),
                    Spacer(),
                    
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaMensajes()),
                );
              },
              child: Container(
                height: 55.0,
                margin: EdgeInsets.symmetric(
                  horizontal: 40
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kPrimaryColorDark,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.message,size: 25,color: Colors.white),
                    SizedBox(width: 15),
                    Text(
                      "Mensajes Enviados",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      )
                    ),
                    Spacer(),
                    /*
                    FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: 25,
                      color: Colors.white54,
                    ),
                    */
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 10),
            GestureDetector(
              onTap: (){
                cerrarSesion(context);
              },
              child: Container(
                height: 55.0,
                margin: EdgeInsets.symmetric(
                  horizontal: 40
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kPrimaryColorDark,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.power_settings_new,size: 25,color: Colors.white),
                    SizedBox(width: 15),
                    Text(
                      "Cerrar Sesión",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      )
                    ),
                    Spacer(),
                    /*
                    FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: 25,
                      color: Colors.white54,
                    ),
                    */
                  ],
                ),
              ),
            ),
      ],
    ); 
    
  }

}