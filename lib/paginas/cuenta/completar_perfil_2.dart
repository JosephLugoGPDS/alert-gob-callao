

import 'package:EstoyaTuLado/modelos/userinfo.dart';
import 'package:EstoyaTuLado/servicios/user.service.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../servicios/auth.dart';
import '../../utils/constantes.dart';
import 'completar_perfil_3.dart';


class CompletarPerfil2 extends StatefulWidget {
  @override
  _CompletarPerfil2State createState() => _CompletarPerfil2State();
}

class _CompletarPerfil2State extends State<CompletarPerfil2> {

  UserMoreInfo informacion = new UserMoreInfo();
  final AuthService auth = AuthService();


  final _formKey = GlobalKey<FormState>();
  final userProvider = UserInfoProvider();
  FirebaseUser user;
  //model use

  //textfield
  final _distritoController = TextEditingController();
  final _direccionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(206,40,112,1.0),
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
                    "Complete sus datos",
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
              
              value: 0.50,
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
                decoration: textInputDecoration.copyWith(hintText: 'Distrito de residencia'),
                onSaved: (val)=> informacion.distrito= val,
                validator: (val) => val.isEmpty ? 'Ingrese un distrito' : null,
                onChanged: (val) {},
                controller: _distritoController,
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Dirección y/o referencia'),
                onSaved: (val)=> informacion.direccion= val,
                validator: (val) => val.isEmpty ? 'Ingrese su dirección' : null,
                onChanged: (val) {},
                controller: _direccionController,
              ),

              //TO DO datepicker
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(1932, 3, 5),
                        maxTime: DateTime(2002, 6, 7),
                        theme: DatePickerTheme(
                          headerColor: Color(0xFFb2abb3),
                          backgroundColor: Color(0xFFcd2b6d),
                          itemStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                          doneStyle: TextStyle(color: Color(0xFFcd2b6d), fontSize: 18)), 
                        onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      print('confirm $date');
                    }, currentTime: DateTime.now(), locale: LocaleType.es);
                    
                  },
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Fecha de nacimiento',
                        style: TextStyle(color: Colors.white),
                        textScaleFactor: 1.5,
                      ),
                      Icon(Icons.date_range, color: Colors.white,size: 30,)
                    ],
                  )),

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
                  child: Text('Siguiente',
                      style: TextStyle(color: Color.fromRGBO(206,40,112,1.0), fontSize: 25)),
                  onPressed: () async {
                    
                    if(_formKey.currentState.validate()){

                            _formKey.currentState.save();

                            //auxiliar para guardar info
                            UserMoreInfo aux;
                            informacion.id = user.uid;
                            aux = await userProvider.cargarInformacion(informacion);

                            //actualizar
                            await userProvider.actualizarInformacion(aux);

                            Navigator.of(context).push(
                            MaterialPageRoute(
                            builder: (context)=>CompletarPerfil3()));
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
                  // Navigator.of(context).pop();
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
                  //No perder el estado
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => Configuracion()));
                },
              ),
            ],
          ),
        ));
  }

//Datepicker

}
