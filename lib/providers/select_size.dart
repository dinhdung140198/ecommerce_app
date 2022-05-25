import 'package:flutter/material.dart';

class SelectSize with ChangeNotifier {
  String? _size ;
  String? get getSize {
    return _size;
  }

  void setSize(String selectedSize) {
    _size = selectedSize;
    notifyListeners();
  } 
}