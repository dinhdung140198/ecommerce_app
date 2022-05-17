import 'dart:convert';

import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];
  final String? authToken;
  final String? userId;

  Products(this.authToken, this.userId, this._items);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSendProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/products.json?$authToken&$filterString');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url = Uri.parse(
          'https://flutter-update-89c84-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken');
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          name: prodData['title'],
          price: prodData['price'],
          description: prodData['description'],
          urlImage: prodData['imageUrl'],
          category: prodData['category'],
          rate: prodData['rate'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

   Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://flutter-update-89c84-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.name,
            'description': newProduct.description,
            'imageUrl': newProduct.urlImage,
            'price': newProduct.price,
            'rate':newProduct.rate,
          }));
      _items[prodIndex] = newProduct;
    } else {
      print('...');
    }

    notifyListeners();
  }

  // Future<void> addProduct(Product product) async {
  //   var url = Uri.parse(
  //       ('https://flutter-update-89c84-default-rtdb.firebaseio.com/categories.json?auth=$authToken'));
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode(
  //         {
  //           'title': product.name,
  //           'price': product.price,
  //           'description': product.description,
  //           'imageUrl': product.urlImage,
  //           'creatorId': userId,
  //         },
  //       ),
  //     );
  //     final newProduct = Product(
  //       name: product.name,
  //       description: product.description,
  //       urlImage: product.urlImage,
  //       id: json.decode(response.body)['name'],
  //       price: product.price
  //     );
  //     _items.add(newProduct);
  //     notifyListeners();
  //   } catch (error) {
  //     throw(error);
  //   }
  // }

  // Future<void> updateProduct(String id, Product newProduct) async {
  //   final prodIndex = _items.indexWhere((prod) => prod.id == id);
  //   if (prodIndex >= 0) {
  //     final url = Uri.parse(
  //         'https://flutter-update-89c84-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
  //     await http.patch(url,
  //         body: json.encode({
  //           'title': newProduct.name,
  //           'description': newProduct.description,
  //           'imageUrl': newProduct.urlImage,
  //           'price': newProduct.price
  //         }));
  //     _items[prodIndex] = newProduct;
  //   } else {
  //     print('...');
  //   }

  //   notifyListeners();
  // }
}
