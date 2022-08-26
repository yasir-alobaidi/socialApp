import 'package:flutter/material.dart';

class Giver<Object> extends ChangeNotifier {
  bool isApproved = false;


  String? id;
  String? name;
  String? username;
  //String? email;
  String? country;
  String? displayName;
  List? categories;

  String profileImage = 'assets/init_pic.png';
  String? bio;

  Giver(
      {this.displayName,
      isApproved,
       this.id,
       this.name,
       this.username,
      //this.email,
       this.country,
       this.categories,
      profileImage,
      this.bio});

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'id': id,
        'name': name,
        'username': username,
        //'email': email,
        'country': country,
        'categories': categories,
        'profileImage': profileImage,
        'bio': bio,
        'isApproved': isApproved,
      };

      Map<String, dynamic> editInfo() => {
        'name': name,
        'username': username,
        'bio': bio,
      };
}
