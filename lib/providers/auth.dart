import 'dart:async';
import 'dart:convert';
import 'package:ecommerce_app/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expriryDate;
  String? _userId;
  Timer? _authTimer;
  String? _userEmail;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expriryDate != null &&
        _expriryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  String? get userEmail {
    return _userEmail;
  }

  Future<void> _authenticate(
      String? email, String? password, String? urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAkPhfcDqj13SFnVl4d-RBmucKk3wYxf-c');
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _userEmail = responseData["email"];
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expriryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expriryDate!.toIso8601String()
      });

      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signIn(
    String? email,
    String? password,
  ) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> signUp(
    String? email,
    String? password,
  ) async {
    return await _authenticate(email, password, 'signUp').then((_) {
      addUser();
    });
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        (json.decode(prefs.getString('userData')!)) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expriryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> resetPassword(String? email, String? password) async {
    var url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:resetPassword?key=AIzaSyAkPhfcDqj13SFnVl4d-RBmucKk3wYxf-c');
    try {
     final response= await http.post(
        url,
        body: json.encode({"oobCode": email, "newPassword": password}),
      );
      if(response.statusCode==200){
        final responseData =json.decode(response.body);
        print('ok');
      }
    } catch (error) {}
  }

  Future<void> addUser() async {
    var url = Uri.parse(
        'https://flutter-update-89c84-default-rtdb.firebaseio.com/users/$userId.json');
    try {
      await http.post(
        url,
        body: json.encode(
          {
            'name': 'add user',
            'email': _userEmail,
            'gender': 'no gender',
            'dateOfBirth': DateFormat('yyyy-MM-dd').format(DateTime.now()),
            'avartar': 'https://ketnoiocop.vn/Content/images/user.png',
            'address': 'add your address'
          },
        ),
      );
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expriryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expriryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
