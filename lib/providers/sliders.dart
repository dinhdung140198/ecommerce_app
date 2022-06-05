import 'dart:convert';

import 'package:ecommerce_app/models/slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SliderList with ChangeNotifier {
  List<Sliders> _listSlider = [];
  final String? authToken;

  SliderList(this.authToken);
  List<Sliders> get list {
    return [..._listSlider];
  }

  Future<void> fetchSlider() async {
    final url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/sliders.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List;
      if (extractedData == null) {
        return;
      }
      final List<Sliders> loadedData = [];
      extractedData.forEach((element) {
        loadedData.add(Sliders.fromJson(element)
        );
      });
      _listSlider = loadedData;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
