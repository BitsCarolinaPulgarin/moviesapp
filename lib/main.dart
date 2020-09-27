import 'package:flutter/material.dart';
import 'package:peliculas_app/src/pages/home.dart';
import 'package:peliculas_app/src/pages/peli_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context ) => Home(),
        'detalle': (BuildContext context ) => PeliculaDetalle(),
      },
    );
  }
}