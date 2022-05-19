import 'package:ecommerce_app/models/cart.dart';
import 'package:flutter/material.dart';

class OrderItem {
  final String? id;
  final double? amount;
  final List<CartItem>? products;
  final DateTime? dateTime;
  final String? shipAddress;
  final String? orderStatus;
  final String? phone;
  final String? email;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
    @required this.shipAddress,
    @required this.orderStatus,
    @required this.phone,
    @required this.email,
  });
}
