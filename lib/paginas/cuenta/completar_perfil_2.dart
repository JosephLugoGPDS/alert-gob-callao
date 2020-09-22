import 'package:EstoyaTuLado/modelos/userinfo.dart';
import 'package:EstoyaTuLado/servicios/dbUser.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../servicios/auth.dart';
import '../../utils/constantes.dart';
import 'completar_perfil_3.dart';
import 'package:EstoyaTuLado/utils/capitalizar.dart';

//datePicker2
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

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

  final format = DateFormat("yyyy-MM-dd");

  //textfield
  TextEditingController _fechaController = TextEditingController();
  

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
            Padding(
                padding: EdgeInsets.symmetric(
              vertical: 20.0,
            )),
            LinearProgressIndicator(
              value: 0.50,
              backgroundColor: Color(0xFFeae3ea),
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFF636364),
              ),
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
    informacion.id = user.uid;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: FutureBuilder(
          future: userProvider.getInformacion(informacion.id),
          builder: (context, snapshot) {
            UserMoreInfo inf = snapshot.data;
            if (snapshot.hasData) {
              return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      // initialValue: inf.distrito,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Distrito de residencia'),
                      onSaved: (val) => inf.distrito = val.capitalize(),
                      validator: (val) =>
                          val.isEmpty ? 'Ingrese un distrito' : null,
                      onChanged: (val) {},
                      controller: TextEditingController(text: inf.distrito),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      // initialValue: inf.direccion,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Dirección y/o referencia'),
                      onSaved: (val) => inf.direccion = val.capitalize(),
                      validator: (val) =>
                          val.isEmpty ? 'Ingrese su dirección' : null,
                      onChanged: (val) {},
                      controller: TextEditingController(text: inf.direccion),
                    ),

                    //TO DO datepicker
                    Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                    // BasicDateField(),

                    Column(children: <Widget>[
                      // Text('Fecha de nacimiento'),
                      DateTimeField(
                        // initialValue: inf.fecha.cast<DateTime>(),
                        format: format,
                        validator: (date) =>
                            date.toString().isEmpty ? 'Fecha inválida' : null,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Fecha de nacimiento'),
                        controller: _fechaController=TextEditingController(text: inf.fecha),
                        onShowPicker: (context, currentValue) {
                          return DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1940, 1, 1),
                              maxTime: DateTime(2005, 12, 15),
                              theme: DatePickerTheme(
                                  headerColor: kSecondaryColor,
                                  backgroundColor: kPrimaryColor,
                                  itemStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  doneStyle: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 18)), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            print('confirm $date');
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.es);
                        },
                      ),
                    ]),

                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    SizedBox(height: 20.0),
                    ButtonTheme(
                      minWidth: 400,
                      height: 50.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)),
                        color: Colors.white,
                        child: Text('Siguiente',
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 25)),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();


                            final fech = _fechaController.text.toString().trim();

                            inf.id = informacion.id;

                            inf.fecha = fech;
                            //actualizar
                            await userProvider.actualizarInformacion(inf);

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CompletarPerfil3()));
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10.0),
                    FlatButton(
                      child: Text(
                        "Regresar",
                        style:
                            TextStyle(color: Color(0xFFeae3ea), fontSize: 18.0),
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
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
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
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
