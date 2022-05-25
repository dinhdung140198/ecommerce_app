import 'package:ecommerce_app/config/extention.dart';
import 'package:flutter/material.dart';

class CartItem {
  String? id;
  String? productId;
  String? name;
  double? price;
  int? quantity;
  String? urlImage;
  Color? color;
  String? size;
  CartItem({
    @required this.id,
    @required this.productId,
    @required this.name,
    @required this.price,
    @required this.quantity,
    @required this.urlImage,
    @required this.color,
    @required this.size,
  });

  get values => null;

  CartItem.fromJson(Map<dynamic, dynamic> map) {
    id = map['id'];
    productId = map['productId'];
    name = map['title'];
    price = map['price'];
    quantity = map['quantity'];
    urlImage = map['urlImage'];
    color = HexColor.fromHex(map['color']);
    size = map['size'];
  }
  tojson(){
    return{
      'id':id,
      'productId':productId,
      'name':name,
      'price':price,
      'quantity':quantity,
      'urlImage':urlImage,
      'color':color,
      'size':size,
    };
  }
}
