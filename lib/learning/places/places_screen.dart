import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../components/list_place.dart';
import 'dart:convert';

class PlaceScreen extends StatelessWidget{
  void goToDetail(BuildContext context,id){
    Navigator.of(context).pushNamed('/detail', arguments: id);
  }

  @override 
  Widget build(BuildContext context){

    final settings = ModalRoute.of(context)?.settings;
    
    final arguments = settings?.arguments;
    
    final route = json.decode(json.encode(arguments)) as Map<String, dynamic>;
    // print(route);
    // final route = 
    final id = route['id'];
    final title = route['title'];

    //print(id);
    
    final placeLists = PLACES_DUMMY_DATA.where((place){     
      // return place.category == id
      // print(place.category);
      // print(id);
      return true;
    }).toList();

    print(placeLists.length);

    return Scaffold(
      appBar : AppBar(
        title : Text("Wisata : "+title.toString())
      ),

      body : ListView.builder(
        itemCount: placeLists.length,
        itemBuilder: (ctx,index) {
          return ListPlace(
            placeLists[index].id,
            placeLists[index].name,
            placeLists[index].image,
            placeLists[index].description
          );
          // print("index " + index.toString());
          // // return Text(placeLists[index].description);
          // if (index >= placeLists.length) {
          //   return Text("No More");
          // }else{                
          //   return Card(
          //     elevation: 5,
          //     child : ListTile(
          //       leading: Image.network(placeLists[index].image.toString()),
          //       title: Text(placeLists[index].name.toString()),
          //       subtitle: Text(placeLists[index].description.toString().substring(0,2) + "..."),
          //       // CARE FULL WITH subbstring(0,2)
          //       onTap : () => goToDetail(context,placeLists[index].id.toString())
          //     )
          //   );
          // }
        },
      )
    );
  }
}