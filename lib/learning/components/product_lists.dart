import 'package:flutter/material.dart';
import "../models/cart.dart";

class ProductList extends StatelessWidget {
  List<Cart> carts = [];

  ProductList(this.carts);

  @override 
  Widget build(BuildContext context){
    return Container(
      height : 400,
      child : carts.isEmpty 
        ? Column(
          children: <Widget>[
            Text("No Transaction Data")
          ],
        )
        : ListView.builder(
          itemCount: carts.length,
          itemBuilder: (BuildContext contxet,int index){
            return Card(
              child : Row(
                children: <Widget>[
                  Container(
                    margin : EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                    padding : EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border : Border.all(    
                        width: 2
                      )
                    ),
                    child: Text(
                      carts[index].qty.toString(),
                      style : TextStyle(
                        color : Colors.red[100],
                        fontSize: 10,
                        fontWeight:  FontWeight.bold
                      )
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(carts[index].title.toString(),style: TextStyle(color : Colors.red[10]),),
                      Text('Harga : Rp '+(carts[index].harga == null ? "-" : carts[index].harga!.toStringAsFixed(0)),style: TextStyle(fontSize: 12,color : Colors.red[10]),)
                    ],
                  )
                ],
              )
            );
          }
        )
    );
  }
}