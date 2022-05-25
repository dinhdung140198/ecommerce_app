import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_app/models/cart.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += (cartItem.price! * cartItem.quantity!);
    });
    return double.parse(total.toStringAsFixed(2));
  }

  int? productCount(String productId) {
    int? count = 0;
    if (_items.containsKey(productId)) {
      _items.values.forEach((element) {
        count = element.quantity;
      });
    }
    return count;
  }

  void addItem({String? productId, double? price, String? name, String? urlImage,
      Color? color, String? size}) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId!,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              productId: productId,
              name: existingCartItem.name,
              price: existingCartItem.price,
              urlImage: existingCartItem.urlImage,
              color: existingCartItem.color,
              size: existingCartItem.size,
              quantity: existingCartItem.quantity! + 1));
    } else {
      _items.putIfAbsent(
          productId!,
          () => CartItem(
              id: DateTime.now().toString(),
              productId: productId,
              urlImage: urlImage,
              name: name,
              price: price,
              color: color,
              size: size,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity! > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              productId: productId,
              id: existingCartItem.id,
              name: existingCartItem.name,
              price: existingCartItem.price,
              urlImage: existingCartItem.urlImage,
              color: existingCartItem.color,
              size: existingCartItem.size,
              quantity: existingCartItem.quantity! - 1));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}


  // Future<void> fetchCartProduct() async{
  //   var url = Uri.parse('https://flutter-update-89c84-default-rtdb.firebaseio.com/cart/$userId.json?$authToken');
  //   try {
  //     final response = await http.get(url);
  //     final extractedData = json.decode(response.body) as Map<String ,dynamic>;
  //     // final extractedData.forEach((prodId, value) { 

  //     // });
  //   } catch (error) {
  //     throw(error);
  //   }
  // }