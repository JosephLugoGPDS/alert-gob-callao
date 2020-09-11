import 'package:EstoyaTuLado/modelos/usuario.dart';
import 'package:EstoyaTuLado/paginas/autenticacion/resetPassword.dart';
import 'package:EstoyaTuLado/paginas/splashScreen.dart';
import 'package:EstoyaTuLado/paginas/wrapper.dart';
import 'package:EstoyaTuLado/servicios/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

var route = <String, WidgetBuilder> {
  "/reset": (BuildContext context) => new ResetearPass(),
  "/wrapper":(BuildContext context) => new Wrapper(),
};

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
        child: MaterialApp(
          home: SplashScreen(),
          localizationsDelegates: [                             
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            DefaultMaterialLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('es','ES'),
          ],
          routes: route
        ),
    );
  }
}
