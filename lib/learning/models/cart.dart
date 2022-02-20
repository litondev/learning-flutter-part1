import 'package:flutter/foundation.dart';

class Cart {
  String? id;
  String? title;
  int? harga;
  int? qty;

  Cart({
    @required this.id,
    @required this.title,
    @required this.harga,
    @required this.qty
  });
}