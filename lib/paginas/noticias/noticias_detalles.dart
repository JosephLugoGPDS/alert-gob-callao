import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


class DetallesNoticia extends StatefulWidget {
  String titulo, subtitulo, contenido, urlImagen,fechaPublicacion;

  DetallesNoticia(
      { this.titulo,
        this.subtitulo,
        this.contenido,
        this.urlImagen,
        this.fechaPublicacion
      });

  @override
  _DetallesNoticiaState createState() => _DetallesNoticiaState();
}

class _DetallesNoticiaState extends State<DetallesNoticia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          Container(
             height: MediaQuery.of(context).size.width,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                   color: Colors.black26 , 
                   offset: Offset(0.0, 2.0),
                   blurRadius: 6.0,
                  ),
                ]
             ),
             child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.network(
                  widget.urlImagen == null
                    ? 'https://firebasestorage.googleapis.com/v0/b/geo-app-f9457.appspot.com/o/imagenes%2FNoImagen.png?alt=media&token=ac93f8c2-3c34-4187-b58c-83971cb2a996'
                    :widget.urlImagen,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
             ) 
           ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            child: Text(
              widget.titulo,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Text(
              widget.subtitulo,
              style: TextStyle(fontSize: 17.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5.0, 10.0, 20.0, 10.0),
            child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  widget.fechaPublicacion,
                  style: TextStyle(fontSize: 17.0),
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
            child: Html(
              data: widget.contenido,
            )
          ),
        ],
      ),
    ));
  }
}
