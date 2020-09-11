import 'package:EstoyaTuLado/servicios/auth.dart';
import 'package:EstoyaTuLado/servicios/dbMensaje.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:EstoyaTuLado/servicios/dbContactos.dart';
import 'package:EstoyaTuLado/utils/constantes.dart';
import 'package:EstoyaTuLado/modelos/contactos.dart';
import 'package:EstoyaTuLado/paginas/contactos/contactos_detalle.dart';

class Contactos extends StatefulWidget {
  @override
  _ContactosState createState() => _ContactosState();
}

class _ContactosState extends State<Contactos> {
  // DATOS DEL USUARIO ACTUAL
  final AuthService _auth = AuthService();
  FirebaseUser user;

  
  final db = ServiciosContactos();

  @override
  void initState() {
    db.getContactos();
    initUser();
    super.initState();
  }

  @override
  void dispose() {
    db.cancel();
    super.dispose();
  }

  initUser() async {
    user = await _auth.getCurrentUser();
    setState(() {
      idUsuario = user.uid;
      nombre = user.displayName;
      telefono = user.photoUrl;
      correo = user.email;
    });
  }

  String idUsuario;
  String nombre;
  String telefono;
  String correo;

  //FORMULARIO MENSAJE
  String asunto = '';
  String mensaje = '';

  var _controller = TextEditingController();
  var _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Contacto",
              style: TextStyle(fontSize: 22, color: Color.fromRGBO(206,40,112,1.0)),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Center(
        child: ValueListenableBuilder<List<Contacto>>(
          valueListenable: db.contactos,
          builder: (context, contactos, _) {
            return contactos != null
                ? SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      /*
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                        child: Container(
                          height: 230.0,
                          width: 400.0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35.0),
                              color: Color.fromRGBO(46,48,48,1.0),
                              boxShadow: [
                                BoxShadow(color: Colors.white10, spreadRadius: 1)
                              ]
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 20.0),
                                  child: Text("¿Necesita Ayuda?",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  )
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        Icon(Icons.phone_android,color: Color.fromRGBO(215,24,104,1.0)),
                                        Padding(padding: EdgeInsets.only(left: 10.0)),
                                        Text("+51 (1) 923 740 039",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white
                                          )
                                        )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        FaIcon(FontAwesomeIcons.whatsapp, color: Color.fromRGBO(215,24,104,1.0)),
                                        Padding(padding: EdgeInsets.only(left: 10.0)),
                                        Text("+51 (1) 923 740 039",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white
                                          )
                                        )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        Icon(Icons.phone,color: Color.fromRGBO(215,24,104,1.0),),
                                        Padding(padding: EdgeInsets.only(left: 25.0)),
                                        Text("+51 (1) 74 74 242",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white
                                          )
                                        )
                                    ],
                                  ),
                                ),
                              ],
                            ) ,
                          ),
                        ),
                      ),
                      */
                      // BLOQUE 2
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                        child: Container(
                          height: 310.0,
                          width: 400.0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35.0),
                              color: Color.fromRGBO(206,40,112,1.0),
                              boxShadow: [
                                BoxShadow(color: Colors.white10, spreadRadius: 1)
                              ]
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        Padding(padding: EdgeInsets.only(left: 10.0)),
                                        Text("Contactos",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white
                                          )
                                        )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
                                    child: ListView.builder(
                                      itemCount: contactos.length,
                                      itemBuilder: (_, index) => ListTile(
                                        title: Text(contactos[index].nombreContacto,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white
                                          )
                                        ),
                                        subtitle: Text(contactos[index].telefonoContacto +'\n'+contactos[index].correoContacto,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.grey
                                          )
                                        ),
                                        isThreeLine: true,
                                        trailing: Icon(Icons.more_vert, color: Colors.blueGrey),
                                        leading: CircleAvatar(
                                          radius: 20.0,
                                          backgroundColor: Colors.white,
                                          child: Text(contactos[index].nombreContacto.substring(0,1), style: TextStyle(color: Color.fromRGBO(206,40,112,1.0),fontSize: 25),),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (_) => ContactoDetalle(contacto: contactos[index]),
                                          ));
                                        },
                                      )
                                    )
                                  )
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 20.0),
                                  child: contactos.length < 2 
                                        ? Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                Padding(padding: EdgeInsets.only(left: 200.0)),
                                                RawMaterialButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (_) => ContactoDetalle(),
                                                    ));
                                                  },
                                                  elevation: 2.0,
                                                  fillColor: Colors.white,
                                                  child: Icon(
                                                    Icons.person_add,
                                                    size: 20.0,
                                                    color: Color.fromRGBO(206,40,112,1.0),
                                                  ),
                                                  padding: EdgeInsets.all(15.0),
                                                  shape: CircleBorder(),
                                                )
                                            ],
                                        ) : null
                                ),
                              ],
                            ),
                          ),
                        ), 
                      ),

                      // BLOQUE 3
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 330.0, 10.0, 0.0),
                        child: Container(
                          width: 400.0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35.0),
                              color: Color.fromRGBO(206,40,112,1.0),
                              boxShadow: [
                                BoxShadow(color: Colors.white10, spreadRadius: 1)
                              ]
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 0.0),
                                  child: TextField(
                                    controller: _controller,
                                    decoration: textInputDecoration.copyWith(

                                      hintText: 'Asunto',
                                      suffixIcon: IconButton(
                                        onPressed: () => _controller.clear(),
                                        icon: Icon(Icons.clear),
                                      ),
                                    ),
                                    maxLines: null, 
                                    onChanged: (val){
                                      setState(() => asunto = val);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                  child: TextField(
                                    controller: _controller2,
                                    decoration: textInputDecoration.copyWith(
                                      hintText: 'Mensaje',
                                      suffixIcon: IconButton(
                                        onPressed: () => _controller2.clear(),
                                        icon: Icon(Icons.clear),
                                      ),
                                    ), 
                                    minLines: 3,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    onChanged: (val){
                                      setState(() => mensaje = val);
                                    },
                                  ),
                                ),
                                ButtonTheme(
                                  minWidth: 200,
                                  height: 50.0,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Color.fromRGBO(206,40,112,1.0))
                                    ),
                                    color: Colors.white,
                                    child: Text('Enviar', style: TextStyle(color: Color.fromRGBO(206,40,112,1.0),fontSize: 25)),
                                    onPressed: () async {                 
                                      ServiciosMensaje(uid: user.uid).mandarMensaje(idUsuario, mensaje, asunto, nombre,telefono, correo); 
                                      _controller.clear();
                                      _controller2.clear();
                                    },
                                  ),
                                ),
                                SizedBox(height: 20.0),
                              ],
                            ),
                          )
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 900.0, 10.0, 20.0),
                      )
                    ],
                  )
                ): const Center(
                  child: CircularProgressIndicator(),
                );
          },
        ),
      ),
    );
  }
}

