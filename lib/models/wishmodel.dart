import 'dart:convert';

WishModel wishModelFromJson(String str) => WishModel.fromJson(json.decode(str));

String wishModelToJson(WishModel data) => json.encode(data.toJson());

class WishModel {
  WishModel({
    required this.fullName,
    required this.username,
    required this.profileImage,
    required this.wishText,
    required this.createdAt,
  });

  String fullName;
  String username;
  String profileImage;
  String wishText;
  DateTime createdAt;

  factory WishModel.fromJson(Map<String, dynamic> json) => WishModel(
        fullName: json["fullName"],
        username: json["username"],
        profileImage: json["profileImage"],
        wishText: json["wishText"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "username": username,
        "profileImage": profileImage,
        "wishText": wishText,
        "createdAt": createdAt.toIso8601String(),
      };
}
