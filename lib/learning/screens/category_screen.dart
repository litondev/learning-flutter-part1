import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import '../components/list_category.dart';
import '../dummy_data.dart';

class CategoryScreen extends StatelessWidget {
  Widget build(BuildContext context){
    return Scaffold(
      appBar : AppBar(
        title : Text("Aplikasi")
      ),
      body : GridView(
        padding : EdgeInsets.all(15),
        children: CATEGORIES_DUMMY_DATA
          .map((item) => ListCategory(item.id,item.title,item.description,item.image))
          .toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300, 
            childAspectRatio: 1.5,
            crossAxisSpacing: 20, 
            mainAxisSpacing: 20, 
          )
      )
    );
  }
}