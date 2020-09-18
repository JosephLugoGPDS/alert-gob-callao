import 'package:EstoyaTuLado/modelos/userinfo.dart';
import 'package:EstoyaTuLado/servicios/user.service.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../servicios/auth.dart';
import '../../utils/constantes.dart';

class CompletarPerfil3 extends StatefulWidget {
  @override
  _CompletarPerfil3State createState() => _CompletarPerfil3State();
}

class _CompletarPerfil3State extends State<CompletarPerfil3> {

  UserMoreInfo informacion = new UserMoreInfo();
  final AuthService auth = AuthService();


  final _formKey = GlobalKey<FormState>();
  final userProvider = UserInfoProvider();
  FirebaseUser user;
  //model use

  //textfield
  final _nombreContactoController = TextEditingController();
  final _telContactoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Container(
              height: 180,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/imagenes/fondo.png"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TypewriterAnimatedTextKit(
                  text: [
                    "Contacto de Respaldo",
                  ],
                  textStyle: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                  alignment: AlignmentDirectional.topCenter,
                  speed: Duration(milliseconds: 80),
                  totalRepeatCount: 1,
                )),

            Padding(padding: EdgeInsets.symmetric(vertical: 20.0,)),
            
            LinearProgressIndicator(
              
              value: 0.75,
              backgroundColor: Color(0xFFeae3ea),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF636364),),
            ),

            FutureBuilder(
              future: auth.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ])),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final user = snapshot.data;
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Nombre de Contacto'),
                validator: (val) => val.isEmpty ? 'Ingrese un nombre' : null,
                onSaved: (val) => informacion.respaldoName = val,
                controller: _nombreContactoController,
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: textInputDecoration.copyWith(
                    hintText: 'Celular de Contacto'),
                onSaved: (val) =>informacion.respaldoTel = val,
                validator: (val) => val.length<7?'Ingrese un teléfono o celular válido':null,
                controller: _telContactoController,
              ),

              
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              SizedBox(height: 20.0),
              ButtonTheme(
                minWidth: 400,
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side:
                          BorderSide(color: Colors.white)),
                  color: Colors.white,
                  child: Text('Guardar',
                      style: TextStyle(color: kPrimaryColor, fontSize: 25)),
                  //   //ToDo Guardar datos
                  onPressed: ()async{
                    
                    if(_formKey.currentState.validate()){

                            _formKey.currentState.save();

                            //auxiliar para guardar info
                            UserMoreInfo aux;
                            informacion.id = user.uid;
                            aux = await userProvider.cargarInformacion2(informacion);

                            //actualizar
                            await userProvider.actualizarInformacion(aux);

                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }
                  },
                ),
              ),
              SizedBox(height: 10.0),
              FlatButton(
                child: Text(
                  "Regresar",
                  style: TextStyle(
                      color: Color(0xFFeae3ea), fontSize: 18.0),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 10.0),
              FlatButton(
                child: Text(
                  "No deseo modificar más datos",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18.0),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ));
  }


}
