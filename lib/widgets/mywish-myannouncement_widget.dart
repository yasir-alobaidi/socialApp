import 'dart:convert';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wish_wall/models/postmodel.dart';
import 'package:wish_wall/providers/posts.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:wish_wall/widgets/special_icon.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MyWishWidget extends StatefulWidget {
  MyWishWidget({
    required this.name,
    required this.username,
    required this.wishText,
    required this.profileImage,
    required this.wishUploadTime,
    this.wId,
    this.wishPrivacy,
    Key? key,
  }) : super(key: key);

  String name;
  String username;
  String? wId;
  String? wishPrivacy;
  String wishText;
  String profileImage;
  String wishUploadTime;

  final DateTime uploadTime = DateTime.now();
  var formatter = DateFormat('dd/M/yyyy -').add_Hm();
  var now = DateTime.now();

  @override
  _MyWishWidgetState createState() => _MyWishWidgetState();
}

class _MyWishWidgetState extends State<MyWishWidget> {
  bool selectedWState = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final user = FirebaseAuth.instance.currentUser;

  TextEditingController newWish = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kaccentColor.withOpacity(0.25),
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ],
          //border: Border.all(color: kaccentColor.withOpacity(0.2), width: 2),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
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
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/init_pic.png'),
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
                        widget.name.text
                            .minFontSize(16)
                            .color(kMainColor)
                            .maxFontSize(16)
                            .fontWeight(FontWeight.w700)
                            .make(),
                        // datamodel.user.bio.text
                        //     .minFontSize(12)
                        //     .maxFontSize(13)
                        //     .color(Colors.blue)
                        //     .make(),
                        widget.username.text
                            .minFontSize(11)
                            .color(kMainColor)
                            .maxFontSize(11)
                            //.fontWeight(FontWeight.w700)
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
                            widget.wishUploadTime.text
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: widget.wishText.text.make(),
          ),
          const SizedBox(
            child: Divider(
              color: Color.fromARGB(40, 0, 0, 0),
            ),
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 30,
                color: Colors.transparent,
                child: InkWell(
                    onTap: () {
                      if (user!.displayName == 'Wisher') {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0))),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 247, 250),
                                  title: const Text('Delete Wish?'),
                                  content: const Text(
                                      'Are you sure you want to delete this wish?'),
                                  actions: [
                                    TextButton(
                                        onPressed: (() {
                                          final url =
                                              'http://10.0.2.2:5000/deletewish';

                                          final response_save = http
                                              .post(Uri.parse(url),
                                                  body: json.encode({
                                                    'wishId': widget.wId,
                                                  }))
                                              .then((value) {
                                            print('deleted');
                                          }).then((value) {
                                            final snackBar = SnackBar(
                                              content: Text(
                                                  'Your wish has been deleted! '),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                            Get.back();
                                          });
                                        }),
                                        child: const Text('Delete')),
                                    TextButton(
                                        onPressed: (() {
                                          Get.back();
                                        }),
                                        child: const Text('Cancel')),
                                  ],
                                ));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0))),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 247, 250),
                                  title: const Text('Delete Announcement?'),
                                  content: const Text(
                                      'Are you sure you want to delete this announcement?'),
                                  actions: [
                                    TextButton(
                                        onPressed: (() {
                                          final url =
                                              'http://10.0.2.2:5000/deleteann';

                                          final response_save = http
                                              .post(Uri.parse(url),
                                                  body: json.encode({
                                                    'annId': widget.wId,
                                                  }))
                                              .then((value) {
                                            print('deleted');
                                          }).then((value) {
                                            final snackBar = SnackBar(
                                              content: Text(
                                                  'Your announcement has been deleted! '),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                            Get.back();
                                          });
                                        }),
                                        child: const Text('Delete')),
                                    TextButton(
                                        onPressed: (() {
                                          Get.back();
                                        }),
                                        child: const Text('Cancel')),
                                  ],
                                ));
                      }
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.pink,
                    )),
              ),
              Container(
                height: 30,
                color: Colors.transparent,
                child: InkWell(
                    onTap: () {
                      newWish.text = widget.wishText;
                      setState(() {
                        final url = 'http://10.0.2.2:5000/edit_wish';

                        final response_save = http.post(Uri.parse(url),
                            body: json.encode({
                              'wishId': widget.wId,
                              'wishText': newWish.text,
                            }));

                        final url2 = 'http://10.0.2.2:5000/edit_ann';

                        final response_save2 = http.post(Uri.parse(url2),
                            body: json.encode({
                              'annId': widget.wId,
                              'annText': newWish.text,
                            }));
                      });

                      if (user!.displayName == 'Wisher') {
                        showDialog(
                            context: context,
                            builder: (context) => StatefulBuilder(
                                  builder: (context, setState) => AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0))),
                                    backgroundColor: const Color.fromARGB(
                                        255, 255, 247, 250),
                                    title: const Text('Edit your wish'),
                                    content: Column(
                                      children: [
                                        TextFormField(
                                          controller: newWish,
                                          //initialValue: widget.wishText,
                                          maxLines: 5,
                                          maxLength: 140,
                                          decoration: const InputDecoration(
                                            hintText: 'Edit your wish',
                                          ),
                                        ),
                                        Container(
                                          width: 110,
                                          height: 43,
                                          child: AnimatedToggleSwitch<
                                                  bool>.dual(
                                              current: selectedWState,
                                              first: true,
                                              second: false,
                                              dif: 20.0,
                                              innerColor: kbgColor,
                                              borderColor: Colors.transparent,
                                              //borderWidth: 0.3,
                                              height: 55, //coulb be 40
                                              animationOffset:
                                                  const Offset(20.0, 0),
                                              clipAnimation: false,
                                              onChanged: (b) => setState(
                                                  () => selectedWState = b),
                                              colorBuilder: (b) =>
                                                  b ? kbgColor : kbgColor,
                                              iconBuilder: (value) => value
                                                  ? const Icon(
                                                      FontAwesomeIcons
                                                          .earthAmericas,
                                                      size: 20)
                                                  : const Icon(Icons.lock,
                                                      size: 20),
                                              textBuilder: (value) => value
                                                  ? const Center(
                                                      child: DefaultTextStyle(
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black),
                                                      child: Text(
                                                        'Public',
                                                      ),
                                                    ))
                                                  : const Center(
                                                      child: DefaultTextStyle(
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black),
                                                      child: Text(
                                                        'Private',
                                                      ),
                                                    ))),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: (() {
                                            final url =
                                                'http://10.0.2.2:5000/edit_wish';

                                            final response_save = http
                                                .post(Uri.parse(url),
                                                    body: json.encode({
                                                      'wishId': widget.wId,
                                                      'wishText': newWish.text,
                                                    }))
                                                .then((value) {
                                              final snackBar = SnackBar(
                                                content: Text(
                                                    'Your wish has been edited! '),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              Get.back();
                                            });
                                          }),
                                          child: const Text('Submit')),
                                      TextButton(
                                          onPressed: (() {
                                            Get.back();
                                          }),
                                          child: const Text('Cancel')),
                                    ],
                                  ),
                                ));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => StatefulBuilder(
                                  builder: (context, setState) => AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0))),
                                    backgroundColor: const Color.fromARGB(
                                        255, 255, 247, 250),
                                    title: const Text('Edit your annoucement'),
                                    content: Column(
                                      children: [
                                        TextFormField(
                                          controller: newWish,
                                          maxLines: 5,
                                          maxLength: 140,
                                          decoration: const InputDecoration(
                                            hintText: 'Edit your annoucneement',
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: (() {
                                            final url =
                                                'http://10.0.2.2:5000/edit_ann';

                                            final response_save = http
                                                .post(Uri.parse(url),
                                                    body: json.encode({
                                                      'annId': widget.wId,
                                                      'annText': newWish.text,
                                                    }))
                                                .then((value) {
                                              final snackBar = SnackBar(
                                                content: Text(
                                                    'Your announcement has been edited! '),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              Get.back();
                                            }).then((value) {
                                              print(
                                                  'EDITTEEDDDDD::::::::DDDDD');
                                            });
                                            ;
                                          }),
                                          child: const Text('Submit')),
                                      TextButton(
                                          onPressed: (() {
                                            Get.back();
                                          }),
                                          child: const Text('Cancel')),
                                    ],
                                  ),
                                ));
                      }
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.pink,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
