import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wish_wall/models/usermodel.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wish_wall/screens/main/chat_screen.dart';
import 'package:wish_wall/screens/main/inbox.dart';
import 'package:wish_wall/screens/main/wisher_profile.dart';

import '../screens/main/search.dart';

class InboxCard extends StatefulWidget {
  static String name = '';
  static String username = '';

  InboxCard({Key? key,  required name, required username}) : super(key: key);

  @override
  State<InboxCard> createState() => _InboxCardState();
  
}

class _InboxCardState extends State<InboxCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: Get.height * 0.1,
        width: Get.width * 0.98,
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
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 15),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/init_pic.png'),
                radius: 26,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InboxCard.name.text
                      .size(17)
                      .fontWeight(FontWeight.w700)
                      .make(),
                  const Divider(
                    height: 5,
                  ),
                  ('@' + InboxCard.username).text.size(13).make(),
                ],
              ),
            ),
            const Spacer(),
            const Padding(
                padding: EdgeInsets.only(right: 25),
                child: Icon(
                  CupertinoIcons.chat_bubble,
                  color: Colors.pink,
                )),
          ],
        ),
      ),
    );
  }
}
