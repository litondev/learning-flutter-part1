import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages/product_page.dart';
import './providers/products.dart';

class MyApp extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return MultiProvider(
      providers : [
        ChangeNotifierProvider(create: (_) => Products())      
      ],
      child : MaterialApp(
        title: 'Testing',
        theme : ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.pink,
          accentColor: Colors.yellow
        ),
        routes : {
          '/' : (ctx) => ProductPage()
        }
      )
    );
  }
}