import 'package:firebase_auth/firebase_auth.dart';
import 'package:EstoyaTuLado/modelos/usuario.dart';

class AuthService{

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

      // Update the username
      await updateUserName(nombre, telefono, result.user);
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

}