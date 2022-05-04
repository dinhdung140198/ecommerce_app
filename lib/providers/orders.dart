import 'dart:convert';

import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Orders with ChangeNotifier {
  List<OrderItem> _order = [];
  final String? authToken;
  final String? userId;

  Orders(this.authToken, this.userId, this._order);

  List<OrderItem> get orders {
    return [..._order];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final response = await http.get(
      url,
    );
    final List<OrderItem> loadOrder = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadOrder.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  name: item['title'],
                  price: item['price'],
                  quantity: item['quantity'],
                  urlImage: item['urlImage']))
              .toList(),
          dateTime: DateTime.parse(orderData['dateTime'])));
    });
    _order = loadOrder.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    final url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProduct
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.name,
                    'quantity': cp.quantity,
                    'price': cp.price,
                    'urlImage': cp.urlImage
                  })
              .toList(),
        }));
    _order.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: cartProduct,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
