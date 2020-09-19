import 'package:EstoyaTuLado/modelos/userinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:EstoyaTuLado/modelos/usuario.dart';
import 'package:flutter/material.dart';

import 'dbUser.dart';


final userProvider = UserInfoProvider();

class AuthService{

  //ToDo: change user moreInfo

    //model use
  UserMoreInfo informacion = new UserMoreInfo();


  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Crear objeto usuario basado en FirebaseUser
  User _userFromFirebaseUser (FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  //  auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      .map(_userFromFirebaseUser);
  } 

  /// Obtener UID
  Future<String> getCurrentUID() async {
    return (await _auth.currentUser()).uid;
  }
  
  /// Obtener usuario actual (Current user)
  Future getCurrentUser() async{
    return await _auth.currentUser();
  }

  // Sign in (Login) con email y contraseña
  Future signInConEmailyPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Regitro con email y contraseña
  Future registroConEmailyPassword(String email, String password, String nombre, String telefono) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      informacion.id = user.uid;
      informacion.email = email;
      

      // Update the username
      await updateUserName(nombre, telefono, result.user);

      informacion.nombre = nombre;
      informacion.celular = telefono;

      await userProvider.actualizarInformacion(informacion);

      return _userFromFirebaseUser(user);


    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future updateUserName(String nombre, String telefono, FirebaseUser user) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = nombre;
    userUpdateInfo.photoUrl = telefono;
    await user.updateProfile(userUpdateInfo);
    //actualize el state
    await user.reload();
  }




  // Sign out (Cerrar Sesion)
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Recuperar Cuenta(Resetear contraseña)
  Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  //!Phone authentication
  Future createUserWithPhone(String phone, BuildContext context) async {
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 0),
        verificationCompleted: (AuthCredential authCredential) {
          _auth.signInWithCredential(authCredential).then((AuthResult result){
            Navigator.of(context).pushReplacementNamed('/home');
          }).catchError((e) {
            return "error";
          });
        },
        verificationFailed: (AuthException exception) {
          return "error";
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          final _codeController = TextEditingController();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text("Enter Verification Code From Text Message"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[TextField(controller: _codeController)],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("submit"),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    var _credential = PhoneAuthProvider.getCredential(verificationId: verificationId,
                        smsCode: _codeController.text.trim());
                    _auth.signInWithCredential(_credential).then((AuthResult result){
                      // Navigator.of(context).pushReplacementNamed('/home');
                    }).catchError((e) {
                      return "error";
                    });
                  },
                )
              ],
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
        });
  }
}

