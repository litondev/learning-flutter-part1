import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            leading: Icon(Icons.home),
            title: Text('Flutter Basic')
        ),
      )
    );
  }
}