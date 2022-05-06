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
    final url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/users/$userId.json?auth=$authToken');
    final response = await http.get(
      url,
    );
    final extractedUser =json.decode(response.body) as Map<String,dynamic>;
    // extractedUser.forEach((key, value) {
    //   _user.id=key;
    //   _user.name= value['name'];
    //   _user.dateOfBirth= value['dateOfBirth'];
    //   _user.avartar=value['avartar'];
    //   _user
    // });
    _user= UserModel.advanced(extractedUser.keys.toString(), extractedUser['name'], extractedUser['email'], extractedUser['exavartar'], extractedUser['gender'], extractedUser['address'], extractedUser['dateOfBirth']); 
    notifyListeners();
  }

  Future<void> addUser() async {
    var url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/users/$userId.json?auth=$authToken');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'name': '',
            'email': userEmail,
            'gender': '',
            'dateOfbirth': DateTime.now(),
            'avartar': 'https://ketnoiocop.vn/Content/images/user.png',
            'address': ''
          },
        ),
      );
      final newUser = UserModel.advanced(
        json.decode(response.body)['name'],
        '',
        userEmail,
        'https://ketnoiocop.vn/Content/images/user.png',
        '',
        '',
        DateTime.now(),
      );
      _user = newUser;
      notifyListeners();
    } catch (error) {
      throw (error);
    }

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
          _user =user;
          notifyListeners();
    }
  }
}
