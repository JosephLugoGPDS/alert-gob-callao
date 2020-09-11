import 'package:flutter/material.dart';
import 'package:EstoyaTuLado/paginas/noticias/noticias_detalles.dart';
import 'package:EstoyaTuLado/servicios/dbNoticias.dart';
import 'package:EstoyaTuLado/modelos/noticias.dart';


class ListaNoticias extends StatefulWidget {

  @override
  ListaNoticiasState createState() => ListaNoticiasState();
}

class ListaNoticiasState extends State<ListaNoticias> {

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
      appBar: AppBar(
        title: Text("Noticias",style: TextStyle(fontSize: 22)),
        backgroundColor: Color.fromRGBO(206,40,112,1.0),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
        child: ValueListenableBuilder<List<Noticia>>(
          valueListenable: db.noticias,
          builder: (context, noticias, _) {
            return noticias != null
                ? Padding(
                    padding: EdgeInsets.all(5.0),
                    child: ListView.builder(
                      itemCount: noticias.length,
                        itemBuilder: (_, index) => Container(
                            margin: EdgeInsets.only(bottom: 16),
                            height: 150,
                            child: Stack(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    noticias[index].url == null
                                      ?'https://firebasestorage.googleapis.com/v0/b/geo-app-f9457.appspot.com/o/imagenes%2FNoImagen.png?alt=media&token=ac93f8c2-3c34-4187-b58c-83971cb2a996'
                                      :noticias[index].url,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                        
                                ),
                                Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.black45.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context,MaterialPageRoute(builder: 
                                      (context)=>DetallesNoticia(
                                        titulo: noticias[index].titulo,
                                        subtitulo: noticias[index].subtitulo,
                                        contenido:noticias[index].contenido,
                                        urlImagen: noticias[index].url,
                                        fechaPublicacion:noticias[index].fechaPublicacion
                                      )
                                    ));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          noticias[index].titulo,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 15,color:Colors.white ,fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          noticias[index].fechaPublicacion,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 15,color:Colors.white ,fontWeight: FontWeight.w500)
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                        
                      )
                   ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
