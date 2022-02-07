import 'package:flutter/material.dart';
import "./screens/formRegister.dart";

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title : 'Form',
      home : Scaffold(
        appBar: AppBar(
          title : Text('Form Register')
        ),
        body : RegisterScreen()
      )
    );
  }
}