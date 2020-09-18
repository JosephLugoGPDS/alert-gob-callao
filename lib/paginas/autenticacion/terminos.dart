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
              height: 40.0,
            ),
            SizedBox(
              width: 350,
              child: Text(
                " Al respecto, declaro que la información ingresada en el presente aplicativo es veraz, la cual formulo en el marco de la Ley N° 29973, Ley General de la Persona con Discapacidad, Decreto Legislativo N° 1468, que establece las disposiciones de prevención y protección para las personas con discapacidad ante la emergencia ocasionada por el COVID-19 y de conformidad con el Principio de Presunción de Veracidad previsto en el numeral 1.7 del artículo IV y artículo 42 de la Ley N° 27444, Ley del Procedimiento Administrativo General, sujetandome a las acciones legales que deriven de la verificación posterior que compruebe la falsedad de la presente declaración, de acuerdo a la legislación vigente.",
                style: TextStyle(
                  fontSize: 20.0,
                  color: kSecondaryColor,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 40.0,
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
