import 'package:flutter/material.dart';


class Sidebar extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Drawer(
      child : Column(
        children: <Widget>[
          AppBar(title: Text("Testing"),automaticallyImplyLeading :  false),

          Divider(),

          ListTile(
            leading: Icon(Icons.devices),
            title: Text("Inventory"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed("/");
            }
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.lens),
            title : Text("Manage Inventory"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed("/manage-product");
            },
          )
        ],
      )
    );
  }
}