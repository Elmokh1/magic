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

  UserModel({this.id, this.name, this.email, this.photo="", this.isPhoto=false,this.address="",this.phone=""});

  UserModel.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?['id'],
          name: data?['name'],
          email: data?['email'],
          photo: data?['photo'],
          isPhoto: data?['isPhoto'],
          address: data?['address'],
          phone: data?['phone'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo': photo,
      'isPhoto': isPhoto,
      'address': address,
      'phone': phone,
    };
  }
}
