import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/models/product.dart';

class Categories with ChangeNotifier {
  List<Category> _categoryList = [];
  List<Product> _productList = [];

  List<Category> get categoryList {
    return [..._categoryList];
  }

  List<Product> get productList {
    return [..._productList];
  }

  Future<void> fetchCategory() async {
    final url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/categories.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return null;
      }
      final List<Category> loadCategories = [];
      extractedData.forEach((cateId, cateVal) {
        loadCategories.add(
          Category(
              id: cateId,
              nameCategory: cateVal['name'],
              image: cateVal['image'],
              rate: cateVal['rate']),
        );
      });
      _categoryList = loadCategories;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> getProductByCategories(String category) async {
    final url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<Product> loadProduct = [];
      extractedData.forEach(
        (prodId, prodValue) {
          if (prodValue['category'] == category) {
            loadProduct.add(Product.fromJson(prodId, prodValue));
          }
        },
      );
      _productList = loadProduct;
    } catch (error) {
      throw (error);
    }
    notifyListeners();
  }

  Future<void> updateProduct(String id, Category newProduct) async {
    final prodIndex = _categoryList.indexWhere((category) => category.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://flutter-update-89c84-default-rtdb.firebaseio.com/categories/$id.json');
      await http.patch(url,
          body: json.encode({
            'name': newProduct.nameCategory,
            'image': newProduct.image,
            'rate': newProduct.rate,
          }));
      _categoryList[prodIndex] = newProduct;
    } else {
      print('Category List is empty');
    }
    notifyListeners();
  }

  void clear() {
    _productList = [];
  }
}
