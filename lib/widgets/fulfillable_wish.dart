import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wish_wall/models/postmodel.dart';
import 'package:wish_wall/providers/posts.dart';
import 'package:wish_wall/screens/main/chat_screen.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:wish_wall/widgets/special_icon.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../screens/main/search.dart';
import 'wish-announcement_widget.dart';

// ignore: must_be_immutable
class FulfillableWish extends StatefulWidget {
  FulfillableWish({
    Key? key,
    required this.name,
    required this.username,
    required this.wishText,
    required this.profileImage,
    required this.wishUploadTime,
    required this.gender,
    required this.birthDate,
    required this.country,
    required this.emailAddress,
    required this.pNr,
  }) : super(key: key);

  String name;
  String username;
  String wishText;
  String profileImage;
  String wishUploadTime;

  String gender;
  String birthDate;
  String country;
  String emailAddress;
  String pNr;
  String? clickedOnId;

  final String? currentUserId = FirebaseAuth.instance.currentUser!.uid;

  final DateTime uploadTime = DateTime.now();
  var formatter = DateFormat('dd/M/yyyy -').add_Hm();
  var now = DateTime.now();

  @override
  State<FulfillableWish> createState() => _FulfillableWishState();
}

final url = 'http://10.0.2.2:5000/giver_view';
final collectionRef = FirebaseFirestore.instance.collection('Wishers_Accounts');

String giverName = '';

String name = '';
String username = '';
String wishId = '';
String wisherId = '';
String wishText = '';
String wishPrivacy = '';
String wishUploadDate = '';
String wishStatus = '';
String wishCategory = '';

String gender = '';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _FulfillableWishState extends State<FulfillableWish> {
  @override
  void initState() {
    super.initState();
    getWInfo();
    getGiverName();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getGiverName().then((value) {
        giverName = value;
      });
    });
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
                            widget.wishUploadTime
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: widget.wishText.text.make(),
          ),
          const Divider(
            height: 10,
            color: Color.fromARGB(30, 0, 0, 0),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          ),
          Center(
            child: InkWell(
              onTap: () {
                getWInfo();
                showDialog(
                    context: context,
                    builder: (context) => StatefulBuilder(
                          builder: (context, setState) => AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0))),
                            backgroundColor:
                                const Color.fromARGB(255, 255, 247, 250),
                            title: const Icon(
                                FontAwesomeIcons.wandMagicSparkles,
                                size: 35,
                                color: Colors.yellow),
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, top: 5),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/init_pic.png'),
                                      radius: 50,
                                      backgroundColor: kaccentColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width,
                                    height: 200,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 5),
                                          child: Column(children: [
                                            widget.name.text
                                                .minFontSize(18)
                                                .color(kMainColor)
                                                .maxFontSize(18)
                                                .fontWeight(FontWeight.w700)
                                                .make(),
                                            widget.username.text
                                                .minFontSize(17)
                                                .color(kMainColor)
                                                .maxFontSize(17)
                                                //.fontWeight(FontWeight.w700)
                                                .make(),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            widget.gender
                                                .prepend('Gender: ')
                                                .text
                                                .minFontSize(13)
                                                .color(kMainColor)
                                                .maxFontSize(13)
                                                //.fontWeight(FontWeight.w700)
                                                .make(),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            widget.birthDate
                                                .prepend('Birthdate: ')
                                                .text
                                                .minFontSize(13)
                                                .color(kMainColor)
                                                .maxFontSize(13)
                                                //.fontWeight(FontWeight.w700)
                                                .make(),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            widget.country
                                                .prepend('Country: ')
                                                .text
                                                .minFontSize(13)
                                                .color(kMainColor)
                                                .maxFontSize(13)
                                                //.fontWeight(FontWeight.w700)
                                                .make(),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            // SizedBox(
                                            //   width: 200,
                                            //   child:
                                            //       'Email: asdadadas@gmail.com'
                                            //           .text
                                            //           .minFontSize(13)
                                            //           .color(kMainColor)
                                            //           .maxFontSize(13)
                                            //           .overflow(
                                            //               TextOverflow.fade)
                                            //           .make(),
                                            // ),
                                            // const SizedBox(
                                            //   height: 5,
                                            // ),
                                            widget.pNr
                                                .prepend('Phone Number: ')
                                                .text
                                                .minFontSize(13)
                                                .color(kMainColor)
                                                .maxFontSize(13)
                                                //.fontWeight(FontWeight.w700)
                                                .make(),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 190,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChatScreen(
                                                    otherUserId: SearchPage
                                                        .searchedWisherId,
                                                    otherUserName: widget.name,
                                                  )),
                                        ).then((value) {
                                          FirebaseFirestore.instance
                                              .collection('Wishers_Accounts')
                                              .doc(SearchPage.searchedWisherId)
                                              .collection('notifications')
                                              .add({
                                            'noti_body':
                                                'Your wish has been chosen to be fulfilled!',
                                            'noti_type': 'wf',
                                            'date': FieldValue.serverTimestamp()
                                          });
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors
                                            .pink, //background color of button
                                        elevation: 7, //elevation of button
                                        shape: RoundedRectangleBorder(
                                            //to set border radius to button
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        //content padding inside button
                                      ),
                                      child: 'FulFill!'.text.size(15).make(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: const [],
                          ),
                        ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  'Fulfill'.text.size(14).color(Colors.pink).bold.make(),
                  const Padding(padding: EdgeInsets.only(right: 5)),
                  const Icon(FontAwesomeIcons.wandMagicSparkles,
                      color: Colors.pink, size: 16),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          ),
        ],
      ),
    );
  }

  Future<String> getGiverName() async {
    final DocumentSnapshot doc =
        await collectionRef.doc(widget.currentUserId).get().then(
      (value) {
        giverName = value.data()!['name'];
        throw ""; //put to avoid error
      },
    );
    print('GIVER NAME:::::::' + giverName);
    return giverName;
  }

  Future<String> getWInfo() async {
    widget.gender = await _firestore
        .collection('Wishers_Accounts')
        .where('name', isEqualTo: widget.name)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == widget.name) {
            i++;
            widget.gender = value.docs[i].data()['gender'];
          }
        });
        print(widget.gender);
      });
      return widget.gender;
    });

    widget.birthDate = await _firestore
        .collection('Wishers_Accounts')
        .where('name', isEqualTo: widget.name)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == widget.name) {
            i++;
            widget.birthDate = value.docs[i].data()['birthdate'];
          }
        });
        print(widget.birthDate);
      });
      return widget.birthDate;
    });

    widget.country = await _firestore
        .collection('Wishers_Accounts')
        .where('name', isEqualTo: widget.name)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == widget.name) {
            i++;
            widget.country = value.docs[i].data()['country'];
          }
        });
        print(widget.country);
      });
      return widget.country;
    });

    // widget.emailAddress = await _firestore
    //     .collection('Wishers_Accounts')
    //     .where('name', isEqualTo: widget.name)
    //     .get()
    //     .then((value) {
    //   setState(() {
    //     int i = -1;
    //     value.docs.forEach((element) {
    //       if (element.data()['name'] == widget.name) {
    //         i++;
    //         widget.emailAddress = value.docs[i].data()['gender'];
    //       }
    //     });
    //     print(widget.emailAddress);
    //   });
    //   return widget.emailAddress;
    // });

    widget.pNr = await _firestore
        .collection('Wishers_Accounts')
        .where('name', isEqualTo: widget.name)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == widget.name) {
            i++;
            widget.pNr = value.docs[i].data()['phoneNo'];
          }
        });
        print(widget.pNr);
      });
      return widget.pNr;
    });

    widget.clickedOnId = await _firestore
        .collection('Wishers_Accounts')
        .where('name', isEqualTo: widget.name)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == widget.name) {
            i++;
            widget.clickedOnId = value.docs[i].data()['id'];
          }
        });
        print(widget.clickedOnId);
      });
      SearchPage.searchedWisherId = widget.clickedOnId!;
      return widget.clickedOnId;
    });

    throw '';
  }
}
