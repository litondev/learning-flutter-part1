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

  Future<ProductItem> findById(String id) async {
    final url = "";
    final response = await http.get(url);
    final convert = json.decode(response.body);
    return ProductItem(
      id: convert['id'], 
      title: convert['title'], 
      stock: convert['stock'], 
      description: convert['description']
    );
  } 

  Future<void> addProduct(ProductItem product) async {
    const url = "";
    final response = await http.post(url,
      body : json.encode({
        "title"  : product.title,
        "stock" : product.stock,
        "description" : product.description
      })
    );
    
    _items.add(
      ProductItem(
        id : json.decode(response.body)['name'],
        title : product.title, 
        stock : product.stock,
        description: product.description
      )
    );

    notifyListeners();
  }

  Future<void> changeStock(String id) async {
    final url = "";
    final index = _items.indexWhere((prod) => prod.id == id);
    final stock = _items[index].stock - 1;

    await http.patch(url,body: json.encode({
      'stock' : stock
    }));

    _items[index] = ProductItem(
      id: id, 
      title: _items[index].title, 
      stock: stock, 
      description: _items[index].description
    );
    
    notifyListeners();
  }

  Future<void> updateProduct(ProductItem product) async {
    final url = "";

    await http.patch(url,body : json.encode({
      "title" : product.title,
      "stock" : product.stock,
      "description" : product.description
    }));

    final index = _items.indexWhere((prod) => prod.id == product.id);
    _items[index] = product;
    notifyListeners();
  }

  Future<void> removeProduct(String id) async {
    final url = "";
    await http.delete(url);
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}