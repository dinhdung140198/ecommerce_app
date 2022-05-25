import 'package:flutter/material.dart';

class SelectColor with ChangeNotifier {
  Color? _selectedColor ;
  Color? get getColor {
    return _selectedColor;
  }

  void setColor(Color? selectedColor) {
    _selectedColor = selectedColor;
    notifyListeners();
  } 
}
