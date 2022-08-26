// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wish_wall/models/postmodel.dart';
import 'package:wish_wall/providers/posts.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:wish_wall/widgets/special_icon.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

class WishWidget extends StatelessWidget {
  WishWidget({
    Key? key,
    required this.name,
    required this.username,
    required this.wishText,
    required this.profileImage,
    required this.wishUploadTime,
  }) : super(key: key);
  String name;
  String username;
  String wishText;
  String profileImage;
  String wishUploadTime;

  final DateTime uploadTime = DateTime.now();
  var formatter = DateFormat('dd/M/yyyy -').add_Hm();
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: kaccentColor.withOpacity(0.25),
          blurRadius: 20,
          spreadRadius: 1,
        ),
      ], borderRadius: BorderRadius.circular(10), color: Colors.white),
      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 5),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: kaccentColor,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(profileImage),
                      radius: 28,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        name.text
                            .minFontSize(16)
                            .color(kMainColor)
                            .maxFontSize(16)
                            .fontWeight(FontWeight.w700)
                            .make(),
                        username.text
                            .minFontSize(11)
                            .color(kMainColor)
                            .maxFontSize(11)
                            .make(),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: kMainColor,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            wishUploadTime
                                .toString()
                                .text
                                .letterSpacing(1)
                                .minFontSize(10)
                                .maxFontSize(12)
                                .color(Colors.black)
                                .make(),
                          ],
                        ),
                      ]),
                ),
              ],
            ),
          ),
          const SizedBox(
            child: Divider(
              color: Colors.black38,
            ),
            height: 10,
          ),
          wishText.isEmpty
              ? Container()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: wishText.text.make(),
                ),
        ],
      ),
    );
  }
}
