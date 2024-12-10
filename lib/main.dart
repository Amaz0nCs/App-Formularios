import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prueba/screens/form_selection_screen.dart';
import 'package:prueba/screens/pantallalogin.dart'; // Importamos la pantalla de login

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formulario App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PantallaLogin(), // Cambiamos para que abra el login en lugar de form_selection_screen inicialmente
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'ES'),  // idioma
      ],
    );
  }
}
