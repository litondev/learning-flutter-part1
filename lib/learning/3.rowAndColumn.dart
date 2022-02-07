import 'package:flutter/material.dart';

class MyApp extends StatelessWidget { 
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home : Scaffold(
        body : Column(
          children: [
            Row(
              children: [
                Text('hai1'),
                Text('hai2'),
                Text('hai3')
              ],
            ),
            Column(
              children: [
                Text('hai1'),
                Text('hai2'),
                Text('hai3')
              ],
            )
          ],
        )
      )
    );
  }
}