import 'dart:convert';

import 'package:ecommerce_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  UserModel _user;
  final String? userEmail;
  final String? authToken;
  final String? userId;

  UserProvider(this.authToken, this.userId, this.userEmail, this._user);

  UserModel get user {
    return _user;
  }

  Future<void> fetchSetUser() async {
    print('$userId');
    final url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/users/$userId.json?auth=$authToken');
    final response = await http.get(
      url,
    );
    final extractedUser = json.decode(response.body) as Map<String, dynamic>;
    extractedUser.forEach((key, value) {
      _user.id=key;
      _user.name= value['name'];
      _user.dateOfBirth= DateTime.now();
      _user.avartar=value['avartar'];
      _user.address=value['address'];
      _user.gender=value['gender'];
      _user.email=value['email'];
    });
    // _user = UserModel.advanced(
    //     id: extractedUser.keys.toString(),
    //     name: extractedUser['name'],
    //     email: extractedUser['email'],
    //     avartar: extractedUser['avartar'],
    //     gender: extractedUser['gender'],
    //     address: extractedUser['address'],
    //     dateOfBirth: extractedUser['dateOfBirth']);
    notifyListeners();
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

   Future<void> updateUser(UserModel user) async {
      final url = Uri.parse(
          'https://flutter-update-89c84-default-rtdb.firebaseio.com/users/$userId.json?auth=$authToken');
      await http.patch(url,
          body: json.encode({
            'name': user.name,
            'email': userEmail,
            'gender': user.gender,
            'dateOfbirth': user.dateOfBirth,
            'avartar': user.avartar,
            'address': user.address
          }));
      _user = user;
      notifyListeners();
    }
}
