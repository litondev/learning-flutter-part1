import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductItem {
  String? id;
  String? title;
  int? stock;
  String? description;

  ProductItem({ 
    @required this.id,
    @required this.title,
    @required this.stock,
    @required this.description
  });
}

class Products with ChangeNotifier {
  List<ProductItem> _items = [];


  List<ProductItem> get items {
    return [...items];
  }

  Future<void> fetchProduct() async {
    final url = Uri.parse("http://192.168.8.215:3001/product");
    final response = await http.get(url,
      headers : {
        'accept' : 'application/json'
      }
    );
    final convertData = json.decode(response.body) as Map<String,dynamic>;
    final List<ProductItem> newData = [];

    if(convertData == null) return;

    convertData.forEach((key, value) {
      newData.add(ProductItem(
        id : key,
        title: value['title'],
        stock : value['stock'],
        description:  value['description']
      ));
    }); 

    _items = newData;

    notifyListeners();
  }
}