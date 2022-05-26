import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/order.dart';

class Orders with ChangeNotifier {
  List<OrderItem> _order = [];
  List<OrderItem> _orderShipYet = [];
  List<OrderItem> _orderShipping = [];
  List<OrderItem> _orderShipped = [];
  final String? authToken;
  final String? userId;

  Orders(this.authToken, this.userId, this._order);

  List<OrderItem> get orders {
    return [..._order];
  }

  List<OrderItem> get orderShipYet {
    return [..._orderShipYet];
  }

  List<OrderItem> get orderShipping {
    return [..._orderShipping];
  }

  List<OrderItem> get orderShipped {
    return [..._orderShipped];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final response = await http.get(
      url,
    );
    final List<OrderItem> loadOrder = [];
    final List<OrderItem> loadOrderShipYet = [];
    final List<OrderItem> loadOrderShipped = [];
    final List<OrderItem> loadOrdershipping = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      if (orderData['orderStatus'] == 'yet') {
        loadOrderShipYet.add(OrderItem.fromJson(orderId, orderData));
      }
      if (orderData['orderStatus'] == 'shipping') {
        loadOrdershipping.add(OrderItem.fromJson(orderId, orderData));
      }
      if (orderData['orderStatus'] == 'shipped') {
        loadOrderShipped.add(OrderItem.fromJson(orderId, orderData));
      }
      loadOrder.add(OrderItem.fromJson(orderId, orderData));
    });
    _orderShipped = loadOrderShipped.reversed.toList();
    _orderShipYet = loadOrderShipYet.reversed.toList();
    _orderShipping = loadOrdershipping.reversed.toList();
    _order = loadOrder.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total,
      String shipAddress, String email, String phone) async {
    final url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final timeStamp = DateTime.now();
    OrderItem orderItem = OrderItem(
        amount: total,
        products: cartProduct,
        dateTime: timeStamp,
        shipAddress: shipAddress,
        orderStatus: 'shipping',
        phone: phone,
        email: email);
    final response =
        await http.post(url, body: json.encode(orderItem.toJson()));
    _order.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        shipAddress: shipAddress,
        phone: phone,
        email: email,
        orderStatus: 'shipping',
        products: cartProduct,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
