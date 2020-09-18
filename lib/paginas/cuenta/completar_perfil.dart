import 'package:EstoyaTuLado/paginas/cuenta/completar_perfil_2.dart';
import 'package:EstoyaTuLado/servicios/user.service.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../servicios/auth.dart';
import '../../utils/constantes.dart';

import 'package:EstoyaTuLado/modelos/userinfo.dart';


class CompletarPerfil extends StatefulWidget {

  final Function toggleView;
  CompletarPerfil ({this.toggleView});


  @override
  _CompletarPerfilState createState() => _CompletarPerfilState();
}
class _CompletarPerfilState extends State<CompletarPerfil> {

final AuthService auth = AuthService();


  final _formKey = GlobalKey<FormState>();
  final userProvider = UserInfoProvider();
  FirebaseUser user;

  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<String> getCurrentUID() async {
    return (await _auth.currentUser()).uid;
  }

  //model use
  UserMoreInfo informacion = new UserMoreInfo();

  //textfield
  final _nameController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _fijoController = TextEditingController();
  final _dniController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 180,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: 
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/imagenes/fondo.png"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TypewriterAnimatedTextKit(
                text: [
                  "Complete, \nsus datos",
                ],
                textStyle: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
                alignment: AlignmentDirectional.topCenter,
                speed: Duration(milliseconds: 80),
                totalRepeatCount: 1,
              )
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 20.0,)),
            
            LinearProgressIndicator(
              
              value: 0.25,
              backgroundColor: Color(0xFFeae3ea),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF636364),),
            ),



            FutureBuilder(
              future: auth.getCurrentUser(),
              builder: (context,snapshot){
                
                if(snapshot.connectionState == ConnectionState.done){
                  return displayUserInformation(context,snapshot);
                }else{
                  return CircularProgressIndicator();
                }
              },
            ),
            
          ]
        )
    ),
    );
  }


Widget displayUserInformation(context,snapshot){
    final user = snapshot.data; 
    return Container(
              padding: EdgeInsets.symmetric(vertical:20.0, horizontal:50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      // initialValue: user.displayName,
                      decoration: textInputDecoration.copyWith(hintText: 'Nombres completos'), 
                      onSaved: (val) => informacion.nombre = val,
                      validator: (val) => val.isEmpty ? 'Ingrese sus nombres': null,
                      onChanged: (val){},
                      controller: _nameController,
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      
                      decoration: textInputDecoration.copyWith(hintText: 'Apellidos'),
                      onSaved: (val) => informacion.apellido = val,
                      validator: (val) => val.isEmpty ? 'Ingrese sus apellidos': null, 
                      onChanged: (val){},
                      controller: _apellidoController,
                    ),
                    
                    SizedBox(height: 10.0),
                    TextFormField(
                      
                      keyboardType: TextInputType.phone,
                      decoration: textInputDecoration.copyWith(hintText: 'Teléfono fijo'), 
                      onSaved: (val) => informacion.fijo = int.parse(val),
                      validator: (val) => val.length<7 ? 'Ingrese un telefono fijo válido': null, 
                        onChanged: (val){},
                        controller: _fijoController,
                    ),
                    
                    SizedBox(height: 10.0),
                    TextFormField(
                      
                      keyboardType: TextInputType.phone,
                      decoration: textInputDecoration.copyWith(hintText: 'DNI'),
                      onSaved: (val)=> informacion.dni = int.parse(val),
                      validator: (val) => val.length<8 ? 'Debe ingresar un DNI válido': null,                
                      controller: _dniController,
                      onChanged: (val){},
                    ),
                    SizedBox(height: 20.0),
                    ButtonTheme(
                      minWidth: 400,
                      height: 50.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white,)
                        ),
                        color: Colors.white,
                        child: Text('Siguiente', style: TextStyle(color: kPrimaryColor,fontSize: 25)),
                        onPressed: () async {

                          if(_formKey.currentState.validate()){

                            _formKey.currentState.save();
                            UserMoreInfo aux;
                            informacion.id = user.uid;
                            aux = await userProvider.agregarInformacion(informacion);
                            await userProvider.actualizarInformacion(aux);

                            await auth.updateUserName(informacion.nombre,user.photoUrl, user);

                            Navigator.of(context).push(
                            MaterialPageRoute(
                            builder: (context)=>CompletarPerfil2()));
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10.0),
                    FlatButton(
                      child: Text(
                        "No deseo modificar mis datos",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      onPressed: (){
                        Navigator.of(context).pop();  
                      },
                    ),
                    SizedBox(height: 10.0),
                    // Text(error,style:TextStyle(color: Colors.red,fontSize: 15)),
                  ],
                ),
              )
            );
}


}