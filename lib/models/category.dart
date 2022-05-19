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
}
