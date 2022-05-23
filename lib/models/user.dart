import 'package:intl/intl.dart';

class UserModel {
  String? id ;
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
  UserModel.advanced({this.id,this.name, this.email, this.avartar, this.gender, this.address,
      this.dateOfBirth, this.phone});
  getDateOfBirth() {
    return DateFormat('yyyy-MM-dd').format(this.dateOfBirth!);
  }
}
