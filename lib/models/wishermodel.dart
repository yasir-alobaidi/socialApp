import 'package:flutter/material.dart';

class Wisher<Object> extends ChangeNotifier {
  String? id;
  String? name;
  String? username;
  String? gender;
  //String? email;
  String? country;
  String? birthdate;
  String? phoneNo;
  String? displayName;
  List keywords = [];

  String profileImage = 'assets/init_pic.png';
  String? bio;

  Wisher.noArgs(); //put this here to say SHUT UP to the errors ;)

  Wisher(
      {this.displayName,
      this.id,
      this.name,
      this.username,
      this.gender,
      //this.email,
      this.country,
      this.birthdate,
      this.phoneNo,
      profileImage,
      this.bio});

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'id': id,
        'name': name,
        'username': username,
        'gender': gender,
        //'email': email,
        'country': country,
        'birthdate': birthdate,
        'phoneNo': phoneNo,
        'profileImage': profileImage,
        'bio': bio,
      };

  static Wisher fromJson(Map<String, dynamic> json) => Wisher(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      //email: json['email'],
      gender: json['gender'],
      country: json['country'],
      birthdate: json['birthdate']);

  Map<String, dynamic> editInfo() => {
        'name': name,
        'username': username,
        'bio': bio,
      };
}
