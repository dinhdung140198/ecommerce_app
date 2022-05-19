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

  Future<void> fetchAndSetOrders(String orderStatus) async {
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
      if (orderStatus == 'All') {
        loadOrder.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            shipAddress: orderData['shipAddress'],
            phone: orderData['phone'],
            email: orderData['email'],
            orderStatus: orderData['orderStatus'],
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    id: item['id'],
                    productId: item['productId'],
                    name: item['title'],
                    price: item['price'],
                    quantity: item['quantity'],
                    urlImage: item['urlImage'],
                  ),
                )
                .toList(),
            dateTime: DateTime.parse(orderData['dateTime']),
          ),
        );
      } else {
        if (orderData['orderStatus'] == orderStatus) {
          loadOrder.add(
            OrderItem(
              id: orderId,
              amount: orderData['amount'],
              shipAddress: orderData['shipAddress'],
              phone: orderData['phone'],
              email: orderData['email'],
              orderStatus: orderData['orderStatus'],
              products: (orderData['products'] as List<dynamic>)
                  .map(
                    (item) => CartItem(
                      id: item['id'],
                      productId: item['productId'],
                      name: item['title'],
                      price: item['price'],
                      quantity: item['quantity'],
                      urlImage: item['urlImage'],
                    ),
                  )
                  .toList(),
              dateTime: DateTime.parse(orderData['dateTime']),
            ),
          );
        }
      }
    });
    _order = loadOrder.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total,
      String shipAddress, String email, String phone) async {
    final url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'shipAddress': shipAddress,
          'email': email,
          'phone': phone,
          'orderStatus': 'shipping',
          'products': cartProduct
              .map((cp) => {
                    'id': cp.id,
                    'productId': cp.productId,
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
