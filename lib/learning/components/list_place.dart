import 'package:flutter/material.dart';

class ListPlace extends StatelessWidget{
  String? id;
  String? name;
  String? image;
  String? description;

  ListPlace(this.id,this.name,this.image,this.description);

  void goToDetail(BuildContext context){
    Navigator.of(context).pushNamed('/detail', arguments: id);
  }

  @override 
  Widget build(BuildContext context){
    return Card(
      elevation: 5,
      child : ListTile(
        leading: Image.network(image.toString()),
        title: Text(name.toString()),
        subtitle: Text(description.toString().substring(0,description.toString().length - 1) + "..."),
        onTap : () => goToDetail(context)
      )
    );
  }
}