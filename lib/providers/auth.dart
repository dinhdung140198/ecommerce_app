import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier{
  String? _token;
  DateTime? _expriryDate;
  String? _userId;
  Timer? _authTimer; 

  // bool get isAuth{
  //   return token !=null;
  // }
  Future<void> _authenticate(String?email,String? password,String?urlSegment )async{
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAkPhfcDqj13SFnVl4d-RBmucKk3wYxf-c');
    try{
      final response = await http.post(url,body: json.encode({
        'email':email,
        'password':password,
        'returnSecureToken':true
      }));
      final responseData = json.decode(response.body);
    }catch(error){

    }
    notifyListeners();
  }

  Future<void> signIn(String? email, String? password,) async{
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> signUp(String? email, String? password,) async{
    return _authenticate(email, password, 'signUp');
  }
}