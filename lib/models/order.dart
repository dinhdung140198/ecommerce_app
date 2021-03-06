import 'package:ecommerce_app/config/extention.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:flutter/material.dart';

class OrderItem {
  String? id;
  double? amount;
  List<CartItem>? products;
  DateTime? dateTime;
  String? shipAddress;
  String? orderStatus;
  String? phone;
  String? email;

  OrderItem({
    this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
    @required this.shipAddress,
    @required this.orderStatus,
    @required this.phone,
    @required this.email,
  });
  factory OrderItem.fromJson(String orderId, Map<String, dynamic> map) {
    List<dynamic> list =map['products'];
    List<CartItem> listProduct= list.map((cartItem) => CartItem.fromJson(cartItem)).toList();
    return OrderItem(
      id: orderId,
      amount: map['amount'],
      shipAddress: map['shipAddress'],
      phone: map['phone'],
      email: map['email'],
      orderStatus: map['orderStatus'],
      dateTime : DateTime.parse(map['dateTime']),
      products: listProduct
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'dateTime': dateTime!.toIso8601String(),
      'shipAddress': shipAddress,
      'email': email,
      'phone': phone,
      'orderStatus': 'yet',
      'products': products!
          .map((cp) => {
                'id': cp.id,
                'productId': cp.productId,
                'title': cp.name,
                'quantity': cp.quantity,
                'price': cp.price,
                'urlImage': cp.urlImage,
                'color': cp.color!.toHex(),
                'size': cp.size
              })
          .toList(),
    };
  }
}
