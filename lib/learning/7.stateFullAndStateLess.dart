import 'package:flutter/material.dart';
import './components/product_lists.dart';
import './models/cart.dart';
import './components/dashboard.dart';
import './components/add_new_item.dart';

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Shopping Chart',
      theme : ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.purpleAccent,      
      ),
      home : Home()
    );
  }
}

class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Cart> _carts = [
    Cart(id : "Test1",title : 'Test Title1',harga : 15000,qty : 10),
    Cart(id : "Test2",title : 'Test Title2',harga : 20000,qty : 20),
  ];

  void _resetCarts(){
    setState(() {
      _carts.clear();
    });
  }

  void _addNewItem(String title,double harga,int qty){
    final newItem = Cart(
        id: DateTime.now().toString(),
        title: title,
        harga: harga,
        qty : qty
      );

    setState((){
      _carts.add(newItem);
    });
  }

  void _openModal(BuildContext context){
    showModalBottomSheet(
      context: context, 
      builder: (_) {
        return AddNewItem(_addNewItem);
      }
    );
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title : Text('Daftar Belanjaan'),
        actions : <Widget>[
          TextButton(child: Icon(Icons.clear, color: Colors.white,), onPressed: () => _resetCarts(),)
        ],
      ),    
      body : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Dashboard(_carts), //TAMBAHKAN CODE INI, KITA LETAKKAN DIATAS WIDGET SEBELUMNYA KARENA POSISINYA JUGA AKAN DIRENDER SEBELUM LIST KERANJANG
            ProductList(_carts),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.add),
        onPressed: () => _openModal(context),
      ),
    );
  }
}