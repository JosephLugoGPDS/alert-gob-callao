import 'package:EstoyaTuLado/servicios/auth.dart';
import 'package:EstoyaTuLado/utils/constantes.dart';
import 'package:flutter/material.dart';


class ResetearPass extends StatefulWidget {

  @override
  _ResetearPassState createState() => _ResetearPassState();
}

class _ResetearPassState extends State<ResetearPass> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String error = '';

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
            SizedBox(height: 15.0),
            Center(
              child: Text(
                "Ingrese su Correo",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical:5.0, horizontal:40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Email'), 
                      validator: (val) => val.isEmpty ? 'Ingrese su email': null,
                      onChanged: (val){
                        setState(() => email = val);
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
                        child: Text('Enviar', style: TextStyle(color: Color.fromRGBO(206,40,112,1.0),fontSize: 25)),
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                            await _auth.sendPasswordResetEmail(email);
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 3.0),
                    FlatButton(
                      child: Text(
                        "Volver al Login",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(height: 10.0),
                    Text(error,style:TextStyle(color: Colors.red,fontSize: 15)),
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