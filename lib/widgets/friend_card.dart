import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wish_wall/models/usermodel.dart';
import 'package:velocity_x/velocity_x.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({Key? key, required this.userinbox}) : super(key: key);
  final UserModel userinbox;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: Get.height * 0.09,
      width: Get.width * 0.95,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(28)),
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 5,
                color: Color.fromARGB(24, 233, 30, 98),
                offset: Offset(5, 5))
          ]),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 15),
            child: InkWell(
              onTap: () {
                //navigate to the friend's profile
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  userinbox.profileImage,
                ),
                radius: 26,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userinbox.name.text //maybe username
                    .size(20)
                    .make(),
                const Divider(
                  height: 5,
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {},
                  child: const Icon(CupertinoIcons.chat_bubble,
                      color: Colors.pink))),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {},
                  child: const Icon(Icons.remove_circle, color: Colors.pink))),
        ],
      ),
    );
  }
}
