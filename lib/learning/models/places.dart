import 'package:flutter/foundation.dart';

class Places{
  String? id;
  String? name;
  String? category;
  String? description;
  String? image;
  String? author;
  int? price;

  Places({
    @required this.id,
    @required this.name,
    @required this.category,
    @required this.description,
    @required this.image,
    @required this.author,
    @required this.price
  });
}