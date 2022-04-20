import 'package:flutter/material.dart';

class Product with ChangeNotifier{
  final String? id;
  final String? name;
  final double? price;
  final String? description;
  final double? rate;
  final String? urlImage;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.name,
      @required this.price,
      @required this.description,
      @required this.urlImage,
      @required this.rate,
      this.isFavorite=false});
}
