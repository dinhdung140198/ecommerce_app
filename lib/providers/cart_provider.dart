import 'package:ecommerce_app/models/cart.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int count = 0;

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += (cartItem.price! * cartItem.quantity!);
    });
    return total;
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

  void addItem(String productId, double price, String name, String urlImage) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              name: existingCartItem.name,
              price: existingCartItem.price,
              urlImage: existingCartItem.urlImage,
              quantity: existingCartItem.quantity! + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              urlImage: urlImage,
              name: name,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  // void removeItem(String productId) {
  //   _items.remove(productId);
  //   notifyListeners();
  // }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity! > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              name: existingCartItem.name,
              price: existingCartItem.price,
              urlImage: existingCartItem.urlImage,
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
