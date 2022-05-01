import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/models/product.dart';

class Categories with ChangeNotifier {
  List<Category> _categoryList = [];
  List<Product> _productList =[];

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
          ),
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
            loadProduct.add(
              Product(
                id: prodId,
                name: prodValue['title'],
                price: prodValue['price'],
                description: prodValue['description'],
                urlImage: prodValue['urlImage'],
                category: prodValue['category'],
              ),
            );
          }
        },
      );
      notifyListeners();
      _productList =loadProduct;
    } catch (error) {
      throw (error);
    }
  }
}
