import 'package:EstoyaTuLado/utils/constantes.dart';
import 'package:flutter/material.dart';

class TerminosCondiciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60.0,
            ),
            Text(
              "Términos y Condiciones",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40.0,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 60.0,
            ),
            SizedBox(
              width: 350,
              child: Text(
                "Que, de acuerdo a la Ley N° 29733, Ley de Protección de Datos Personales y su Reglamento, declaro en forma previa, libre, expresa, inequívoca, tener conocimiento sobre la política de tratamiento y privacidad de datos personales, y autorizo expresamente al Gobierno Regional de Callao, a tratar mis datos personales consignados en la presente plataforma virtual, conforme a la ley de la materia.",
                style: TextStyle(
                  fontSize: 20.0,
                  color: kSecondaryColor,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 60.0,
            ),
            ButtonTheme(
              minWidth: 400,
              height: 50.0,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: kSecondaryColor)),
                  color: kSecondaryColor,
                  child: Text('Acepto',
                      style: TextStyle(color: kPrimaryColor, fontSize: 25)),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
