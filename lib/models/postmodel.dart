
import 'package:wish_wall/models/usermodel.dart';

class PostModel {
  PostModel({required this.wishText, required this.uploadTime});
  UserModel user = UserModel(
      name: 'abdallah',
      username: 'abd.k.h',
      bio: 'peaky blindas gang4life',
      profileImage:
          'https://images.unsplash.com/photo-1628157588553-5eeea00af15c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2080&q=80');
  String wishText = '';
  bool wishState = false;
  String uploadTime;
}
