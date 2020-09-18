
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:EstoyaTuLado/utils/constantes.dart';
import 'package:EstoyaTuLado/utils/loading.dart';
import 'package:EstoyaTuLado/servicios/auth.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login> {
  // final AuthService auth = AuthService();


  //!login email

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // TEXT FIELDS STATE
  String email = '';
  String password = '';
  String error = '';


  alertaError() {
    return AlertDialog(
      title: Text("Información Adicional"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: <Widget>[
        ButtonTheme(
          minWidth: 100,
          height: 40,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.blue[900])),
            color: Colors.blue[900],
            child: Text('Entrar',
                style: TextStyle(color: kSecondaryColor, fontSize: 20)),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
      return loading
          ? Loading()
          : Scaffold(
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
                                  image:
                                      AssetImage("assets/imagenes/fondo.png"),
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
                            "Bienvenido,\nIngrese sus \nDatos",
                          ],
                          textStyle: TextStyle(
                            fontSize: 40,
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                          alignment: AlignmentDirectional.topCenter,
                          speed: Duration(milliseconds: 70),
                          totalRepeatCount: 1,
                        )),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 50.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 30.0),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Email'),
                                validator: (val) =>
                                    val.isEmpty ? 'Ingrese su email' : null,
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Contraseña'),
                                obscureText: true,
                                validator: (val) => val.length < 6
                                    ? 'Debe tener 6 o más caracteres'
                                    : null,
                                onChanged: (val) {
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
                                      side: BorderSide(color: kSecondaryColor)),
                                  color: kSecondaryColor,
                                  child: Text('Entrar',
                                      style: TextStyle(
                                          color:
                                              kPrimaryColor,
                                          fontSize: 25)),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() => loading = true);
                                      dynamic result =
                                          await _auth.signInConEmailyPassword(
                                              email, password);
                                      if (result == null) {
                                        setState(() {
                                          error =
                                              'Email o Contraseña incorrectos';
                                          loading = false;
                                        });
                                      }
                                      {}
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 3.0),
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/reset');
                                },
                                child: Text('¿Olvido su contraseña?',
                                    style: TextStyle(
                                        color: kSecondaryColor, fontSize: 18.0)),
                              ),
                              FlatButton(
                                child: Text(
                                  "Crear Cuenta",
                                  style: TextStyle(
                                      color: kSecondaryColor, fontSize: 18.0),
                                ),
                                onPressed: () {
                                  widget.toggleView();
                                },
                              ),
                              SizedBox(height: 10.0),
                              Text(error,
                                  style: TextStyle(
                                      color: Colors.yellowAccent[700],
                                      fontSize: 15)),
                            ],
                          ),
                        ))
                  ])));

  }
}
