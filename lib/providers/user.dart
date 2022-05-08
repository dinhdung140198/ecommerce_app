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
    final response = await http.get(url);
    final extractedUser = json.decode(response.body);
    _user.id = userId;
    _user.name = extractedUser['name'];
    _user.avartar = extractedUser['avartar'];
    _user.address = extractedUser['address'];
    _user.gender = extractedUser['gender'];
    _user.email = extractedUser['email'];
    _user.dateOfBirth = DateTime.parse(extractedUser['dateOfBirth']);
    notifyListeners();
  }

  Future<void> updateUser(UserModel user) async {
    print(userId);
    final url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/users/$userId.json?auth=$authToken');
    await http.patch(url,
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'gender': user.gender,
          'dateOfBirth': DateFormat('yyyy-MM-dd').format(user.dateOfBirth!),
          'avartar': user.avartar,
          'address': user.address
        }));
    _user = user;
    notifyListeners();
  }
}

  // Future<void> addUser() async {
  //   print(' Add user');
  //   var url = Uri.parse(
  //       'https://flutter-update-89c84-default-rtdb.firebaseio.com/users/$userId.json?auth=$authToken');
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode(
  //         {
  //           'name': '',
  //           'email': userEmail,
  //           'gender': '',
  //           'dateOfbirth': DateTime.now(),
  //           'avartar': 'https://ketnoiocop.vn/Content/images/user.png',
  //           'address': ''
  //         },
  //       ),
  //     );
  //     final newUser = UserModel.advanced(
  //       id: json.decode(response.body)['name'],
  //       name: '',
  //       email: userEmail,
  //       avartar: 'https://ketnoiocop.vn/Content/images/user.png',
  //       gender: '',
  //       address: '',
  //       dateOfBirth: DateTime.now(),
  //     );
  //     _user = newUser;
  //     notifyListeners();
  //   } catch (error) {
  //     throw (error);
  //   }
  // }
