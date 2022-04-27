import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String? name;
  final double? price;
  final String? description;
  final double? rate;
  final String? urlImage;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.name,
      @required this.price,
      @required this.description,
      @required this.urlImage,
      @required this.rate,
      this.isFavorite = false});
  void _setFavorValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavorStatus(String? token, String? userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token');
    try {
      final respose = await http.put(url,body: json.encode(isFavorite));
      if(respose.statusCode>=400){
        isFavorite =oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavorite =oldStatus;
      notifyListeners();
    }
  }
}
