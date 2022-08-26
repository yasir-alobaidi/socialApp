// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:wish_wall/models/postmodel.dart';
import 'package:wish_wall/providers/posts.dart';
import 'package:wish_wall/screens/main/search.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:wish_wall/widgets/wish-announcement_widget.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/mywish-myannouncement_widget.dart';

class WviewGProfilePage extends StatefulWidget {
  const WviewGProfilePage({Key? key}) : super(key: key);

  @override
  State<WviewGProfilePage> createState() => _WviewGProfilePage();
}

class _WviewGProfilePage extends State<WviewGProfilePage> {
  String? selectedReportReason;

  @override
  @override
  Widget build(BuildContext context) {
    var postmodel = PostModel(wishText: 'wha wha whaat?', uploadTime: "");
    final postProvider = Provider.of<PostsProvider>(context);
    var listp = postProvider.getpostListing;
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
                  height: Get.height * 0.5,
                ),
                Positioned(
                  left: Get.width * 0.2,
                  right: Get.width * 0.2,
                  bottom: 15,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: ktxtwhiteColor,
                        radius: Get.height * 0.105,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/init_pic.png'),
                          radius: Get.height * 0.1,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(SearchPage.searchedGiverName,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("@" + SearchPage.searchedGiverUsername,
                              style: TextStyle(fontSize: 17)),
                          Text(SearchPage.searchedGiverBio,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w300)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(padding: EdgeInsets.only(right: 10)),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => StatefulBuilder(
                                              builder: (context, setState) =>
                                                  AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25.0))),
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 255, 247, 250),
                                                title:
                                                    const Text('Report User'),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      ToggleSwitch(
                                                        inactiveBgColor:
                                                            Color.fromARGB(255,
                                                                255, 247, 250),
                                                        activeFgColor:
                                                            Colors.white,
                                                        isVertical: true,
                                                        minWidth: 190.0,
                                                        radiusStyle: true,
                                                        cornerRadius: 20.0,
                                                        initialLabelIndex: 2,
                                                        activeBgColors: const [
                                                          [Colors.pink],
                                                          [Colors.pink],
                                                          [Colors.pink],
                                                          [Colors.pink],
                                                          [Colors.pink],
                                                          [Colors.pink],
                                                        ],
                                                        labels: const [
                                                          'Harassement',
                                                          'Racism',
                                                          'Bullying',
                                                          'Inappropriate post/s',
                                                          'Impersonation',
                                                          'Something else',
                                                        ],
                                                        onToggle: (index) {
                                                          //************************ */
                                                          switch (index) {
                                                            case 0:
                                                              selectedReportReason =
                                                                  'Harrasement';
                                                              break;
                                                            case 1:
                                                              selectedReportReason =
                                                                  'Racism';
                                                              break;
                                                            case 2:
                                                              selectedReportReason =
                                                                  'Bullying';
                                                              break;
                                                            case 3:
                                                              selectedReportReason =
                                                                  'Inappropriate post/s';
                                                              break;
                                                            case 4:
                                                              selectedReportReason =
                                                                  'Impersonation';
                                                              break;
                                                            default:
                                                              selectedReportReason =
                                                                  'Something else';
                                                          }
                                                        },
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 20)),
                                                      TextFormField(
                                                        maxLines: 3,
                                                        //maxLength: 140,
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText:
                                                              'Other comments...',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: (() {
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                _thankPopupDialog(
                                                                    context)).then(
                                                            (value) =>
                                                                Get.back());

                                                        //Get.back();
                                                      }),
                                                      child:
                                                          const Text('Submit')),
                                                  TextButton(
                                                      onPressed: (() {
                                                        Get.back();
                                                      }),
                                                      child:
                                                          const Text('Cancel')),
                                                ],
                                              ),
                                            ));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      height: Get.height * 0.04,
                                      width: Get.width * 0.2,
                                      color: kaccentColor,
                                      child: 'Report User'
                                          .text
                                          .size(10)
                                          .color(Colors.white)
                                          .makeCentered(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
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
            Text(SearchPage.searchedGiverName + '\'s announcements',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            listp.isEmpty
                ? SizedBox(
                    child: WishWidget(
                    name: 'name',
                    username: 'username',
                    wishText: 'wishText',
                    profileImage: '',
                    wishUploadTime: '',
                  ) //'No wishes available :('.text.makeCentered(),
                    )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return index % 2 == 0
                          ? FadeInLeft(
                              duration: const Duration(milliseconds: 600),
                              from: 400,
                              child: Container(),
                            )
                          : FadeInRight(
                              duration: const Duration(milliseconds: 600),
                              from: 400,
                              child: Container(),
                            );
                    },
                    itemCount: listp.length,
                  ),
          ],
        ),
      ),
    );
  }

  Widget _thankPopupDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 255, 247, 250),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      title: const Text('Thanks for trying to make our community better!'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
              "We'll review it and remove anything that doesn't follow our Community Standards."),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
