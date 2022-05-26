import 'package:flutter/material.dart';

class Sliders {
  String? image;
  String? button;
  String? description;
  Sliders(
      {@required this.image,
      @required this.button,
      @required this.description});
  Sliders.fromJson(Map<dynamic, dynamic> map) {
    image = map['image'];
    button = map['button'];
    description = map['description'];
  }
}
