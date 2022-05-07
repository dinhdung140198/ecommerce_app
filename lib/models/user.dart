import 'package:flutter/material.dart';

class UserModel {
  String? id ;
  String? name;
  String? email;
  String? gender;
  DateTime? dateOfBirth;
  String? avartar;
  String? address;

  // UserModel.init();
  // UserModel.basic(
  //   this.name,
  //   this.avartar,
  // );
  UserModel.advanced({this.id,this.name, this.email, this.avartar, this.gender, this.address,
      this.dateOfBirth});
}
