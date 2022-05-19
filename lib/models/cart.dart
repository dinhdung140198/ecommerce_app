import 'package:flutter/material.dart';

class CartItem {
  final String? id;
  final String? productId;
  final String? name;
  final double? price;
  final int? quantity;
  final String? urlImage;
  CartItem(
      {@required this.id,
      @required this.productId,
      @required this.name,
      @required this.price,
      @required this.quantity,
      @required this.urlImage
      });

  get values => null;
}
