import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Container(
      margin:  EdgeInsets.all(10.0),
      child : Column( 
        children: <Widget> [
          Row(
            children: <Widget> [
              Icon(Icons.archive),
              Text('Artikel Terbaru',style : TextStyle(fontWeight : FontWeight.bold))
            ],
          ),
          Card(
            child : Column( 
              children: <Widget>[
                Text('Belajar Flutter')
              ],
            )
          )
        ],
      )
    );
  }
}