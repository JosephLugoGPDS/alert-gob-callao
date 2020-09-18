import 'package:EstoyaTuLado/utils/constantes.dart';
import 'package:flutter/material.dart';
import 'package:EstoyaTuLado/servicios/dbLocalizacion.dart';
import 'package:EstoyaTuLado/modelos/localizacion.dart';

class ListaAlertas extends StatefulWidget {
  @override
  _ListaAlertasState createState() => _ListaAlertasState();
}

class _ListaAlertasState extends State<ListaAlertas> {

  final db = ServiciosAlerta();

  @override
  void initState() {
    db.getLocalizacion();
    super.initState();
  }

  @override
  void dispose() {
    db.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Mis Alertas",
              style: TextStyle(fontSize: 22, color: kSecondaryColor),
            )
          ],
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
      ),
      
      body: Padding(
        padding: EdgeInsets.all(0.0),
        child: ValueListenableBuilder<List<Localizacion>>(
          valueListenable: db.alertas,
          builder: (context, alertas, _) {
            return alertas != null
                ? Container (
                  child: ListView.builder(
                    itemCount: alertas.length,
                    itemBuilder: (_, index) => Container(
                      margin: EdgeInsets.all(10.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(46,48,48,1.0),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color:Colors.black26),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            Text(
                              "Problema:",
                              style: TextStyle(fontSize: 18 ,color: kPrimaryColor),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 8)),
                            Text(
                              alertas[index].problema,
                              style: TextStyle(fontSize: 15, color: kSecondaryColor),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            Text(
                              "Fecha:",
                              style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.w400, color: kPrimaryColor),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 8)),
                            Text(
                              alertas[index].fecha.toDate().toIso8601String().substring(0,10),
                              style: TextStyle(fontSize: 15,color: kSecondaryColor),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            Text(
                              "Posición:",
                              style: TextStyle(fontSize: 18 , color: kPrimaryColor),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 8)),
                            Text(
                              alertas[index].userPosition.latitude.toString()+"  ,  "+alertas[index].userPosition.longitude.toString(),
                              style: TextStyle(fontSize: 15, color: kSecondaryColor),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 18)),
                          ],
                        ),  
                      ),
                    )
                    )
                  )
                : const Center(
                    child: Text("No hay alertas"),
                  );
          },
        ),
      ),
    );
  }
}