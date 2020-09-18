
import 'package:EstoyaTuLado/paginas/cuenta/menu.dart';
import 'package:flutter/material.dart';
import 'package:EstoyaTuLado/paginas/noticias/noticias_principal.dart';
import 'package:EstoyaTuLado/paginas/mapa/mapa.dart';
import 'package:EstoyaTuLado/paginas/contactos/contactos_lista.dart';

// MAPA
import 'dart:async';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:EstoyaTuLado/servicios/auth.dart';
import 'package:EstoyaTuLado/servicios/dbLocalizacion.dart';
import 'package:EstoyaTuLado/utils/constantes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  int currentTab = 0;
  final List<Widget> screens = [
    Mapa(),
    Contactos(),
    Noticias(),
    Configuracion()

  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Mapa();

  // MAPA

  final AuthService _auth = AuthService();
  
  FirebaseUser user;
  
  
  @override
  void initState() {
    super.initState();
    initUser();
  }
  
  String nombre;
  String telefono;
  String idUsuario;
  String mensaje;
  double latitude;
  double longitude;

  initUser() async {
    user = await _auth.getCurrentUser();
    setState(() {
      idUsuario = user.uid;
      nombre = user.displayName;
      telefono = user.photoUrl;
    });
  }


  StreamSubscription _streamSubscription;
  Location _tracker = Location();
  Marker marker;
  GoogleMapController _googleMapController;


  @override
  void dispose() {
    if (_streamSubscription != null) {
      _streamSubscription.cancel();
    }
    super.dispose();
  }

  //Function for updateMarker
  void actualizarMarcador(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("marcador"),
          position: latlng,
          draggable: false,
          zIndex: 2,
          flat: false,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      
    });
  }

  Future<Uint8List> getMarcador() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/imagenes/marcador.png");
    return byteData.buffer.asUint8List();
  }
  
  //Funcion que captura la posicion del usuario
  void getCurrentLocation() async {
    try {
      initUser();
      Uint8List imageData = await getMarcador();
      var location = await _tracker.getLocation();
      setState(() {
        latitude = location.latitude;
        longitude = location.longitude;
      });
      actualizarMarcador(location, imageData);

      if (_streamSubscription != null) {
        _streamSubscription.cancel();
      }

      _streamSubscription = _tracker.onLocationChanged.listen((newLocalData) {
        if (_googleMapController != null) {
          _googleMapController
              .animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
                  bearing: 100,
                  target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  tilt: 0,
                  zoom: 18.00)));
          actualizarMarcador(newLocalData, imageData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permiso Denegado");
      }
    }
  }

  enviarGeolocalizacion(BuildContext context){
    getCurrentLocation();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Información Adicional"),
          content: TextField( 
            decoration: textInputDecoration.copyWith(hintText: 'Describa el problema...'), 
            onChanged: (val){
              setState(() => mensaje = val);
            },
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          actions: <Widget>[
            ButtonTheme(
              minWidth: 100,
              height: 40,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: kPrimaryColor)
                ),
                color: kPrimaryColor,
                child: Text('Enviar', style: TextStyle(color: kSecondaryColor,fontSize: 20)),
                onPressed: () async {
                  ServiciosAlerta(uid: user.uid).enviarAlerta(idUsuario,latitude,longitude,mensaje,nombre,telefono);                 
                  Navigator.of(context).pop();
                  setState(() {
                    mensaje = null;
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // FIN MAPA

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket, 
        child: currentScreen
      ),
      floatingActionButton: currentTab == 0 ? FloatingActionButton(
        onPressed: () {
          enviarGeolocalizacion(context);
        },
        backgroundColor: currentTab == 0 ? Colors.red:Colors.grey,
        child: Icon(Icons.add_alert,color: currentTab == 0 ? kSecondaryColor : Colors.grey,),
        tooltip: "Alerta",
      ) : null,
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Mapa(); 
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? kPrimaryColor : Colors.grey,
                        ),
                        Text(
                          'Inicio',
                          style: TextStyle(
                            color: currentTab == 0 ? kPrimaryColor : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      
                      setState(() {
                        currentScreen =
                            Contactos(); 
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.contacts,
                          color: currentTab == 1 ? kPrimaryColor : Colors.grey,
                        ),
                        Text(
                          'Contacto',
                          style: TextStyle(
                            color: currentTab == 1 ? kPrimaryColor : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // DERECHA

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Noticias();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.newspaper, 
                          color: currentTab == 2 ? kPrimaryColor : Colors.grey,
                        ),
                        Text(
                          'Noticias',
                          style: TextStyle(
                            color: currentTab == 2 ? kPrimaryColor : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      
                      setState(() {
                        currentScreen =
                            Configuracion();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.account_box,
                          color: currentTab == 3 ? kPrimaryColor : Colors.grey,
                        ),
                        Text(
                          'Cuenta',
                          style: TextStyle(
                            color: currentTab == 3 ? kPrimaryColor : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
