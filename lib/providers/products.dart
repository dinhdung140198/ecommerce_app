import 'dart:convert';

import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];
  List<Product> get items {
    return [..._items];
  }

  Product findById(String id){
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSendProducts() async {
    var url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            name: prodData['title'],
            price: prodData['price'],
            description: prodData['description'],
            urlImage: prodData['imageUrl'],
            rate: 3));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw(error);
    }
  }
}
