import 'package:EstoyaTuLado/utils/constantes.dart';
import 'package:flutter/material.dart';
import 'package:EstoyaTuLado/servicios/dbMensaje.dart';
import 'package:EstoyaTuLado/modelos/mensajes.dart';

class ListaMensajes extends StatefulWidget {
  @override
  _ListaMensajesState createState() => _ListaMensajesState();
}

class _ListaMensajesState extends State<ListaMensajes> {

  final db = ServiciosMensaje();

  @override
  void initState() {
    db.getMensajes();
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
              "Mis Mensajes",
              style: TextStyle(fontSize: 22, color: kSecondaryColor),
            )
          ],
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
      ),
      
      body: Padding(
        padding: EdgeInsets.all(0.0),
        child: ValueListenableBuilder<List<Mensaje>>(
          valueListenable: db.mensajes,
          builder: (context, mensajes, _) {
            return mensajes != null
                ? Container (
                  child: ListView.builder(
                    itemCount: mensajes.length,
                    itemBuilder: (_, index) => Container(
                      margin: EdgeInsets.all(10.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(46,48,48,1.0),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Color.fromRGBO(46,48,48,1.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Padding(padding: EdgeInsets.only(top: 15)),
                            Text(
                              mensajes[index].asuntoMensaje,
                              style: TextStyle(fontSize: 20,color: kPrimaryColor),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            Text(
                              mensajes[index].contenidoMensaje,
                              style: TextStyle(fontSize: 15, color: kSecondaryColor),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            Text(
                              "Fecha:",
                              style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.w700, color: kSecondaryColor),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 8)),
                            Text(
                              mensajes[index].fecha.toDate().toIso8601String().substring(0,10),
                              style: TextStyle(fontSize: 15, color: kSecondaryColor),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            
                          ],
                        ),  
                      ),
                    )
                    )
                  )
                : const Center(
                    child: Text("No hay mensajes"),
                  );
          },
        ),
      ),
    );
  }
}
