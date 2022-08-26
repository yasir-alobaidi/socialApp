// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class NotificationCard extends StatelessWidget {
  NotificationCard(
    this.mainIcon,
    this.mainIconColor,
    this.notificationText,
    //this.leftendIcon,
    //this.rightendIcon, 
    {
    Key? key,
  }) : super(key: key);

  IconData? mainIcon;
  Color? mainIconColor;
  //InkWell leftendIcon;
  //InkWell rightendIcon;
  String? notificationText;

  @override
  Widget build(BuildContext context) {
    NotificationCard notificationCard = NotificationCard(
        mainIcon, mainIconColor, notificationText);

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: Get.height * 0.1,
        width: Get.width * 0.95,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25)),
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
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: InkWell(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(notificationCard.mainIcon,
                      size: 35, color: mainIconColor),
                  radius: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 230,
                    child: notificationCard.notificationText?.text
                        .overflow(TextOverflow.ellipsis)
                        .size(14)
                        .make(),
                  )
                ],
              ),
            ),
            const Spacer(),
           
          ],
        ),
      ),
    );
  }
}
