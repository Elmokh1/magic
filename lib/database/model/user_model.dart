import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  // data class
  static const String collectionName = 'users';
  String? id;
  String? name;
  String? email;
  String? photo ;
  bool isPhoto;
  String address ;
  String phone;
  String illnessNum;
  String token;

  UserModel({this.id, this.name, this.email, this.photo="", this.isPhoto=false,this.address="",this.phone="",this.illnessNum="",this.token=""});

  UserModel.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?['id'],
          name: data?['name'],
          token: data?['token'],
          email: data?['email'],
          photo: data?['photo'],
          isPhoto: data?['isPhoto'],
          address: data?['address'],
          phone: data?['phone'],
          illnessNum: data?['illnessNum'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
      'token': token,
      'email': email,
      'photo': photo,
      'isPhoto': isPhoto,
      'address': address,
      'phone': phone,
      'illnessNum': illnessNum,
    };
  }
}
