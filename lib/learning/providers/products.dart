import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class ProductItem {
  String? id;
  String? title;
  int? stock;
  int? price;
  String? description;

  ProductItem({ 
    @required this.id,
    @required this.title,
    @required this.stock,
    @required this.price,
    @required this.description
  });
}

class Products with ChangeNotifier {
  List<ProductItem> _items = [];

  List<ProductItem> get items {
    return [
      ..._items
    ];
  }

  Future<void> fetchProduct() async {
    final url = Uri.parse((dotenv.env['API_URL'] as String) + "/product");
    
    final response = await http.get(url,
      headers : {
        'accept' : 'application/json'
      }
    );

    final convertData = json.decode(response.body) as List<dynamic>;

    final List<ProductItem> newData = [];

    if(convertData == null) return;

    convertData.forEach((element) {
      newData.add(
         ProductItem(
          id : element['id'].toString(),
          title: element['title'],
          stock : element['stock'],
          price : element["price"],
          description:  element['description']
        )
      );
    });  

    _items = newData;

    notifyListeners();
  }

  Future<ProductItem> findById(String id) async {
    final url = Uri.parse((dotenv.env['API_URL'] as String) + "/product/" + id);
    
    final response = await http.get(url,
      headers : {
        "accept" : "application/json"
      }
    );

    final convert = json.decode(response.body);

    return ProductItem(
      id: convert['id'].toString(), 
      title: convert['title'], 
      stock: convert['stock'], 
      price : convert["price"],
      description: convert['description'] == null ? '-' : convert["description"]
    );
  } 

  Future<void> addProduct(ProductItem product) async {
    final url = Uri.parse((dotenv.env['API_URL'] as String) + "/product");
    
    final response = await http.post(url,
      headers: <String, String>{
        "Content-Type": "application/json"
      },
      body : jsonEncode(<String, dynamic>{
        "title"  : product.title,
        "stock" : product.stock,
        "price" : product.price,
        "description" : product.description
      })
    );
    
    _items.add(
      ProductItem(
        id : json.decode(response.body)["dataValues"]["id"].toString(),
        title : product.title, 
        stock : product.stock,
        price : product.price,
        description: product.description
      )
    );

    notifyListeners();
  }

  Future<void> changeStock(String id) async {
    final url = Uri.parse((dotenv.env['API_URL'] as String) + "/product/stock/"+id);
    
    final index = _items.indexWhere((prod) => prod.id == id);

    final stock = (_items[index].stock as int) - 1;

    final response = await http.patch(url,
      headers: <String, String>{
        "Content-Type": "application/json"
      },
      body :jsonEncode(<String, dynamic>{
        'stock' : stock
      })
    );

    print(response.body);

    _items[index] = ProductItem(
      id: id, 
      title: _items[index].title, 
      stock: stock, 
      price : _items[index].price,
      description: _items[index].description
    );
    
    notifyListeners();
  }

  Future<void> updateProduct(ProductItem product) async {
    final url = Uri.parse((dotenv.env['API_URL'] as String) + "/product/" + (product.id as String));

    await http.put(url,
      headers: <String, String>{
        "Content-Type": "application/json"
      },
      body :jsonEncode(<String, dynamic>{
        "title" : product.title,
        "stock" : product.stock,
        "price" : product.price,
        "description" : product.description
      })
    );

    final index = _items.indexWhere((prod) => prod.id == product.id);

    _items[index] = product;

    notifyListeners();
  }

  Future<void> removeProduct(String id) async {
    final url = Uri.parse((dotenv.env['API_URL'] as String) + "/product/" + id);

    await http.delete(url,
      headers: {
        "accept" : "application/json"
      }
    );

    _items.removeWhere((prod) => prod.id == id);

    notifyListeners();
  }
}