import 'package:flutter/material.dart';
import "../models/cart.dart";

class Dashboard extends StatelessWidget {
  List<Cart> _listCart = [];

  Dashboard(this._listCart);

  int get totalItem{
    return _listCart.fold(0,(sum,item) => sum += (item.qty  as int));
  }

  double get totalPrice{
    return _listCart.fold(0,(sum,item) => sum += (item.harga as int));
  }

  @override 
  Widget build(BuildContext context){
    return Card(
      elevation: 6,
      margin : EdgeInsets.all(10),
      child : Padding(
        padding: EdgeInsets.all(10),
        child : Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Total Item'),
                SizedBox(height : 4),
                Text(totalItem.toString() + "pcs",style : TextStyle(fontSize: 25,fontWeight: FontWeight.bold))
              ],
            ),
            Column(
              children: <Widget>[
                Text("Total Belanja"),
                SizedBox(height : 4),
                Text(totalPrice.toStringAsFixed(0),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))
              ],       
            )
          ],       
        )
      )
    );
  }
}