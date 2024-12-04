// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Asegúrate de importarlo
import 'package:intl/intl.dart';  // Para trabajar con fechas
import 'package:prueba/screens/form_screen.dart';
import 'package:prueba/screens/login_screen.dart'; // Importa la pantalla de login

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
      home: const LoginScreen(), // Cambiar a la pantalla de login
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'ES'),  // Asegúrate de tener el idioma español
      ],
    );
  }
}
