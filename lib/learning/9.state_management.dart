import 'package:flutter/material.dart';
import 'package:myfirstapp/learning/pages/add_new_product.dart';
import 'package:myfirstapp/learning/pages/master_product_page.dart';
import 'package:provider/provider.dart';

import './pages/product_page.dart';
import './pages/add_new_product.dart';
import './pages/master_product_page.dart';
import './providers/products.dart';

class MyApp extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return MultiProvider(
      providers : [
        ChangeNotifierProvider(
          create: (_) => Products()
        )      
      ],
      child : MaterialApp(
        title: 'Testing',
        theme : ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.pink,
          accentColor: Colors.yellow
        ),
        routes : {
          '/' : (ctx) => ProductPage(),
          '/manage-product' : (ctx) => MasterProductPage(),
          '/add-product' : (ctx) => AddNewProduct()
        }
      )
    );
  }
}