import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_app/models/user.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final String? authToken;
  final String? userId;

  UserProvider(this.authToken, this.userId, this._user);

  UserModel? get user {
    return _user;
  }

  Future<void> fetchSetUser() async {
    final url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/users/$userId.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final extractedUser = json.decode(response.body) as Map<dynamic, dynamic>;
      extractedUser.forEach((key, value) {
        _user = UserModel.fromJson(key, value as Map<dynamic,dynamic>);
      });
    } catch (error) {
      throw (error);
    }
    notifyListeners();
  }

  Future<void> updateUser(UserModel user) async {
    final url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/users/$userId/${user.id}.json?auth=$authToken');
    await http.patch(url,
        body: json.encode(
          user.toJson()
        ));
    _user = user;
    notifyListeners();
  }
}
