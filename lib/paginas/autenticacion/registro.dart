import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:EstoyaTuLado/servicios/auth.dart';
import 'package:EstoyaTuLado/utils/constantes.dart';
import 'package:EstoyaTuLado/utils/loading.dart';


class Registro extends StatefulWidget {

  final Function toggleView;
  Registro ({this.toggleView});

  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // TEXT FIELDS STATE
  String email = '';
  String password = '';
  String nombre = '';
  String error = '';
  //
  String telefono = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
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
                    child: 
                    Container(
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
                  "Bienvenido,\nRegistre sus \ndatos",
                ],
                textStyle: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
                alignment: AlignmentDirectional.topCenter,
                speed: Duration(milliseconds: 70),
                totalRepeatCount: 1,
              )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical:20.0, horizontal:50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Nombre'), 
                      validator: (val) => val.isEmpty ? 'Ingrese su nombre': null,
                      onChanged: (val){
                        setState(() => nombre = val);
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: textInputDecoration.copyWith(hintText: 'Teléfono'), 
                      validator: (val) => val.isEmpty ? 'Ingrese su número de teléfono': null,
                      onChanged: (val){
                        setState(() => telefono = val);
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: textInputDecoration.copyWith(hintText: 'Email'), 
                      validator: (val) => val.isEmpty ? 'Ingrese su email': null,
                      onChanged: (val){
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Contraseña'), 
                      obscureText: true,
                      validator: (val) => val.length < 6 ? 'Debe tener 6 o más caracteres': null,
                      onChanged: (val){
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    ButtonTheme(
                      minWidth: 400,
                      height: 50.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)
                        ),
                        color: Colors.white,
                        child: Text('Registrar', style: TextStyle(color: Color.fromRGBO(206,40,112,1.0),fontSize: 25)),
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                            setState(() => loading = true);
                            dynamic result = await _auth.registroConEmailyPassword(email, password,nombre,telefono);
                            if(result == null){
                              setState(() {
                                error = 'Por favor ingrese un email válido';
                                loading = false;
                              });
                              
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10.0),
                    FlatButton(
                      child: Text(
                        "Ya tengo una cuenta",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      onPressed: (){
                        widget.toggleView();
                      },
                    ),
                    SizedBox(height: 10.0),
                    Text(error,style:TextStyle(color: Colors.yellowAccent[700],fontSize: 15)),
                  ],
                ),
              )
            )
          ]
        )
      )
    );
    
  }
}