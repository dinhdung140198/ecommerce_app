import 'dart:convert';

import 'package:ecommerce_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class UserProvider with ChangeNotifier {
  UserModel _user;
  final String? authToken;
  final String? userId;

  UserProvider(this.authToken, this.userId, this._user);

  UserModel get user {
    return _user;
  }

  Future<void> fetchSetUser() async {
    final url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/users/$userId.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final extractedUser = json.decode(response.body) as Map<String, dynamic>;
      extractedUser.forEach((key, value) {
        _user.id = key;
        _user.name = value['name'];
        _user.address = value['address'];
        _user.gender = value['gender'];
        _user.email = value['email'];
        _user.avartar = value['avartar'];
        _user.dateOfBirth = DateTime.parse(value['dateOfBirth']);
        _user.phone = value['phone'];
      });
    } catch (error) {
      throw(error);
    }
    notifyListeners();
  }

  Future<void> updateUser(UserModel user) async {
    final url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/users/$userId/${user.id}.json?auth=$authToken');
    await http.patch(url,
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'gender': user.gender,
          'dateOfBirth': DateFormat('yyyy-MM-dd').format(user.dateOfBirth!),
          'avartar': user.avartar,
          'address': user.address,
          'phone': user.phone,
        }));
    _user = user;
    notifyListeners();
  }
}
