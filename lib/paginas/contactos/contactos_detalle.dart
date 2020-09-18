import 'package:EstoyaTuLado/utils/constantes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:EstoyaTuLado/modelos/contactos.dart';
import 'package:EstoyaTuLado/servicios/auth.dart';
import 'contactos_detalle_logica.dart';


const separator = const SizedBox(
  height: 25,
);

class ContactoDetalle extends StatefulWidget {
  ContactoDetalle({Key key, this.contacto}) : super(key: key);
  final Contacto contacto;

  @override
  _ContactoDetalleState createState() => _ContactoDetalleState();
}

class _ContactoDetalleState extends State<ContactoDetalle> {
  LogicaDetalles logdet;
  //
  final AuthService _auth = AuthService();

  FirebaseUser user;

  String idUsuario;

  initUser() async {
    user = await _auth.getCurrentUser();
    setState(() {
      idUsuario = user.uid;
    });
  }

  void onSave() {
    logdet.save(idUsuario);
    Navigator.pop(context, true);
  }

  void onDelete() {
    logdet.delete();
    Navigator.pop(context, true);
  }

  @override
  void initState() {
    logdet = LogicaDetalles(widget.contacto);
    logdet.init();
    initUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        actions: <Widget>[
          if (widget.contacto != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.text,
              onChanged: logdet.onNombreChanged,
              controller: logdet.textControllerNombre,
              decoration: InputDecoration(
                labelText: 'Nombre',
                suffixIcon: ValueListenableBuilder<bool>(
                  valueListenable: logdet.valid,
                  builder: (_, value, __) {
                    return value == null
                        ? SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(),
                          )
                        : value
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.check_circle_outline,
                                color: Colors.red,
                              );
                  },
                ),
              ),
            ),
            separator,
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: logdet.textControllerCorreo,
              decoration: InputDecoration(
                labelText: 'Correo',
              ),
            ),
            separator,
            TextField(
              keyboardType: TextInputType.phone,
              controller: logdet.textControllerTelefono,
              decoration: InputDecoration(
                labelText: 'Telefono',
              ),
            ),
            separator,
            ValueListenableBuilder<bool>(
              valueListenable: logdet.valid,
              builder: (_, value, __) {
                return ButtonTheme(
                      minWidth: 400,
                      height: 50.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Color.fromRGBO(215,24,104,1.0))
                        ),
                        color: kPrimaryColor,
                        child: Text('Guardar', style: TextStyle(color: kSecondaryColor,fontSize: 25)),
                        onPressed: value != null && value ? () => onSave() : null,
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}