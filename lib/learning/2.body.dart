import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home : Scaffold(
        body : Container(
          child : Card( 
            child : Column(
              children : <Widget>[
              Image.network("https://images.tokopedia.net/img/cache/200-square/VqbcmM/2021/8/18/a5a38710-2e53-4dec-8302-00de95085135.jpg"),
                  Text('Test')
              ]
            )
          )
        )
      )
    );
  }
}