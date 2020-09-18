import 'package:EstoyaTuLado/utils/constantes.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:EstoyaTuLado/servicios/auth.dart';


class Mapa extends StatefulWidget {

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {

  final AuthService _auth = AuthService();
  
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }
  
  String nombre;
  String idUsuario;
  String telefono;
  double latitude;
  double longitude;

  initUser() async {
    user = await _auth.getCurrentUser();
    setState(() {
      nombre = user.displayName;
      idUsuario = user.uid;
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

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(-11.893288, -76.745256),
    zoom: 8,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Mi Ubicación",
              style: TextStyle(fontSize: 22, color: Colors.white),
            )
          ],
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
      ),
      
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: initialLocation,
              markers: Set.of((marker != null) ? [marker] : []),
              onMapCreated: (GoogleMapController controller) {
                _googleMapController = controller;
              },
            ),
          ),
          FloatingActionButton(
            onPressed: (){
              getCurrentLocation();
            },
            backgroundColor: Colors.grey,
            child: Icon(Icons.location_searching),
          ),          
        ],
      ),
    );
  }
}
