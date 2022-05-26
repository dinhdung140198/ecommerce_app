import 'package:ecommerce_app/config/extention.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  String? id;
  String? name;
  List<Color>? colors;
  List<String>? sizes;
  double? price;
  String? description;
  double? rate;
  String? urlImage;
  String? category;
  bool? isFavorite;

  Product(
      {@required this.id,
      @required this.name,
      @required this.colors,
      @required this.sizes,
      @required this.price,
      @required this.description,
      @required this.urlImage,
      @required this.rate,
      @required this.category,
      this.isFavorite = false});

  Product.fromJson(String productId, Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    List<Color> listColor =[];
    if(map['colors']!=null){
      map['colors'].forEach((value){
        listColor.add(HexColor.fromHex(value));
      });
    }else{
      listColor = [];
    }

    List<String> listSize =[];
    if(map['sizes']!=null){
      map['sizes'].forEach((value){
        listSize.add(value);
      });
    }

    id = productId;
    sizes =listSize;
    colors =listColor;
    name = map['title'];
    price = map['price'];
    description = map['description'];
    urlImage = map['imageUrl'];
    category = map['category'];
    rate = map['rate'];
  }

  toJson(){
    return {
            'title': name,
            'description': description,
            'imageUrl': urlImage,
            'price': price,
            'rate':rate,
            'colors':colors,
            'sizes':sizes,
          };
  }

  // void _setFavorValue(bool newValue) {
  //   isFavorite = newValue;
  //   notifyListeners();
  // }

  Future<void> toggleFavorStatus(String? token, String? userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite!;
    notifyListeners();
    final url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token');
    try {
      final respose = await http.put(url, body: json.encode(isFavorite));
      if (respose.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
