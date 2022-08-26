// ignore_for_file: prefer_const_constructors

//not needed in this version :D

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wish_wall/models/postmodel.dart';
import 'package:wish_wall/providers/posts.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:wish_wall/widgets/friend_card.dart';
import 'package:wish_wall/widgets/wish-announcement_widget.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/usermodel.dart';

class friendsPage extends StatelessWidget {
  const friendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userinobx = UserModel(
        name: 'HHH', username: 'whatever', bio: 'asdas', profileImage: 'asd');

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 141, 179),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  height: Get.height * 0.4,
                ),
                Positioned(
                  left: Get.width * 0.2,
                  right: Get.width * 0.2,
                  bottom: 40,
                  child: Column(
                    children: [
                      Icon(
                        Icons.people,
                        size: 70,
                        color: Colors.white,
                        //backgroundImage:
                        // NetworkImage(postmodel.user.profileImage),
                        //radius: Get.height * 0.1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      'Friends'.text.color(Colors.white).bold.size(25).make()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 30),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 16)),
            FriendCard(userinbox: userinobx),
            FriendCard(userinbox: userinobx),
            FriendCard(userinbox: userinobx),
            FriendCard(userinbox: userinobx),
          ],
        ),
      ),
    );
  }
}
