import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? gender;
  DateTime? dateOfBirth;
  String? avartar;
  String? address;
  String? phone;

  UserModel.init();
  // UserModel.basic(
  //   this.name,
  //   this.avartar,
  // );
  UserModel.advanced({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.avartar,
    @required this.gender,
    @required this.address,
    @required this.dateOfBirth,
    @required this.phone,
  });

  UserModel.fromJson(String key, Map<dynamic, dynamic> map) {
    id = key;
    name = map['name'];
    address = map['address'];
    gender = map['gender'];
    email = map['email'];
    avartar = map['avartar'];
    dateOfBirth = DateTime.parse(map['dateOfBirth']);
    phone = map['phone'];
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'gender': gender,
      'dateOfBirth': DateFormat('yyyy-MM-dd').format(dateOfBirth!),
      'avartar': avartar,
      'address': address,
      'phone': phone,
    };
  }

  getDateOfBirth() {
    return DateFormat('yyyy-MM-dd').format(this.dateOfBirth!);
  }
}
