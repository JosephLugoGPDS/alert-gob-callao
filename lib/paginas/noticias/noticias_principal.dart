import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:EstoyaTuLado/paginas/noticias/noticias_lista.dart';
import 'package:EstoyaTuLado/servicios/dbNoticias.dart';
import 'package:EstoyaTuLado/modelos/noticias.dart';
import 'noticias_detalles.dart';

class Noticias extends StatefulWidget {
  @override
  _NoticiasState createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias> {
  final db = ServiciosNoticia();

  @override
  void initState() {
    db.getNoticias();
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
      backgroundColor: Color.fromRGBO(206,40,112,1.0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Últimas Noticias",
              style: TextStyle(fontSize: 22, color: Color.fromRGBO(206,40,112,1.0)),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Center(
        child: ValueListenableBuilder<List<Noticia>>(
          valueListenable: db.noticias,
          builder: (context, noticias, _) {
            return noticias != null
                ? Padding(
                  padding: EdgeInsets.only(top:30.0),
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap:() => {
                          Navigator.push(context,MaterialPageRoute(builder: 
                          (context)=>DetallesNoticia(
                            titulo: noticias[index].titulo,
                            subtitulo: noticias[index].subtitulo,
                            contenido:noticias[index].contenido,
                            urlImagen: noticias[index].url,
                            fechaPublicacion:noticias[index].fechaPublicacion
                          )))
                        },
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35.0),
                                  topRight: Radius.circular(35.0),
                                ),
                                child: Image.network(
                                  noticias[index].url == null
                                      ?'https://firebasestorage.googleapis.com/v0/b/geo-app-f9457.appspot.com/o/imagenes%2FNoImagen.png?alt=media&token=ac93f8c2-3c34-4187-b58c-83971cb2a996'
                                      :noticias[index].url,
                                  fit: BoxFit.cover,
                                  height: 400.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 340.0, 0.0, 0.0),
                              child: Container(
                                height: 190.0,
                                width: 400.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(35.0),
                                  elevation: 10.0,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 20.0),
                                            child: Text(noticias[index].titulo,
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),)
                                          )
                                        ],
                                      ) ,
                                ),
                              ),
                            ),
                          ],
                        )
                      );
                    },
                    itemCount:noticias == null?0:noticias.length,
                    viewportFraction: 0.8,
                    scale: 0.9,
                  ),
                  
                )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListaNoticias()),
          );
        },
        icon: Icon(Icons.add,color: Color.fromRGBO(206,40,112,1.0),),
        label: Text("Ver más",style: TextStyle(color: Color.fromRGBO(206,40,112,1.0)),),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
