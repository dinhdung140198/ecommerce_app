import 'package:flutter/material.dart';

class Category with ChangeNotifier {
  String? id = UniqueKey().toString();
  String? nameCategory;
  String? image;
  double? rate;

  Category({
    @required this.id,
    @required this.nameCategory,
    @required this.image,
    @required this.rate,
  });

  Category.fromJson(String cateId, Map<dynamic, dynamic> map) {
    id = cateId;
    nameCategory = map['name'];
    image = map['image'];
    rate = map['rate'];
  }
  Map<dynamic, dynamic> toJson() {
    return {
      'name': nameCategory,
      'image': image,
      'rate': rate,
    };
  }
}
