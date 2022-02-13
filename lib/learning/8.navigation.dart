import 'package:flutter/material.dart';

import "./screens/category_screen.dart";
import './places/places_screen.dart';
import './screens/detail_screen.dart';

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title : 'Aplikasi',
      theme : ThemeData(
        primaryColor: Colors.pinkAccent,
        accentColor: Colors.pink,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),

        textTheme: ThemeData.light().textTheme.copyWith(
          headline1 : TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
          subtitle1 : TextStyle(fontWeight: FontWeight.bold)
        ),
      ),

      routes: {
        '/' : (ctx) => CategoryScreen(),
        '/places': (ctx) => PlaceScreen(),
        '/detail': (ctx) => DetailScreen() 
      }
    );
  }
}