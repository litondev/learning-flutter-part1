import 'package:flutter/material.dart';
import "./imports/home.dart";
import "./imports/news.dart";
import "./imports/popular.dart";

class MyApp extends StatefulWidget{
  @override 
  MyTabState createState() => MyTabState();
}

class MyTabState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController? controller;

  @override 
  void initState(){
    super.initState();

    controller = TabController(
      vsync: this,
      length : 3
    );      
  }

  @override
  void dispose() {  
    controller?.dispose();
    super.dispose();    
  }

  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      home : Scaffold(
        appBar: AppBar( 
          title : Text('Hello'),
          backgroundColor: Colors.red[900],

          bottom : TabBar(
            controller: controller,
            tabs : <Tab> [
              Tab(icon : Icon(Icons.home),),
              Tab(icon : Icon(Icons.note),),
              Tab(icon : Icon(Icons.poll))
            ]
          ),         
        ),
        body : TabBarView(
            controller: controller,
            children: <Widget> [
              Home(),
              Popular(),
              News()
            ],
          )
      )
    );
  }
}