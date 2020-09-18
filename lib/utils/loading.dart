import 'package:EstoyaTuLado/utils/constantes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitSquareCircle(
        // color: Color.fromRGBO(234,65,136,1.0),
        color: kPrimaryColor,
        size: 50.0,
        ),
      ),
    );
  }
}