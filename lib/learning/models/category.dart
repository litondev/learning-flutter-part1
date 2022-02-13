import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Category{
  String? id;
  String? title;
  String? description;
  String? image;

  Category({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.image
  });
}