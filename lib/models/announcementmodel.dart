import 'dart:convert';

AnnouncementModel announcementModelFromJson(String str) => AnnouncementModel.fromJson(json.decode(str));

String announcementTextToJson(AnnouncementModel data) => json.encode(data.toJson());

class AnnouncementModel {
  AnnouncementModel({
    required this.fullName,
    required this.username,
    required this.profileImage,
    required this.announcementText,
    required this.createdAt,
  });

  String fullName;
  String username;
  String profileImage;
  String announcementText;
  DateTime createdAt;

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) => AnnouncementModel(
        fullName: json["fullName"],
        username: json["username"],
        profileImage: json["profileImage"],
        announcementText: json["announcementText"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "username": username,
        "profileImage": profileImage,
        "announcementText": announcementText,
        "createdAt": createdAt.toIso8601String(),
      };
}
