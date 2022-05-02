import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class Category with ChangeNotifier {
  String? id =UniqueKey().toString();
  String? nameCategory ;
  String? image;
  // bool? selected;

  Category(
      {@required this.id,
      @required this.nameCategory,@required this.image});
  
}
