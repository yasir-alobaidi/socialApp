// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wish_wall/models/postmodel.dart';
import 'package:wish_wall/providers/posts.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:wish_wall/widgets/wish-announcement_widget.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../models/givermodel.dart';
import '../../widgets/mywish-myannouncement_widget.dart';

class GiverProfilePage extends StatefulWidget {
  GiverProfilePage({Key? key}) : super(key: key);

  @override
  State<GiverProfilePage> createState() => _GiverProfilePageState();
}

class _GiverProfilePageState extends State<GiverProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  final collectionRef =
      FirebaseFirestore.instance.collection('Givers_Accounts');

  final url = 'http://10.0.2.2:5000/giverid';
  final url2 = 'http://10.0.2.2:5000/own_view';

  String name = '';
  String username = '';
  String annId = '';
  String giverId = '';
  String annText = '';
  String annUploadDate = '';
  String bio = '';
  String profileImage = '';

  List<Widget> myAnns = [];

  @override
  void initState() {
    super.initState();
    sendGiverId();
    getTheData();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      sendGiverId();
      getTheData();
      getGiverName().then((value) {
        name = value;
      });
      getGiverUsername().then((value) {
        username = value;
      });
      getGiverBio().then((value) {
        bio = value;
      });
    });

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
                      FutureBuilder(
                          future: getGiverProfilePic(),
                          builder: (contex, snapshot) {
                            return CircleAvatar(
                              backgroundColor: ktxtwhiteColor,
                              radius: Get.height * 0.105,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(profileImage),
                                radius: Get.height * 0.1,
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder(
                              future: getGiverName(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Text(name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold));
                                } else if (snapshot.connectionState ==
                                    ConnectionState.none) {
                                  return Text("No data");
                                }
                                return CircularProgressIndicator();
                              }),
                          FutureBuilder(
                              future: getGiverUsername(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Text('@' + username,
                                      style: TextStyle(fontSize: 17));
                                } else if (snapshot.connectionState ==
                                    ConnectionState.none) {
                                  return Text("No data");
                                }
                                return CircularProgressIndicator();
                              }),
                          FutureBuilder(
                              future: getGiverBio(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Center(
                                      child: Text(bio,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300)));
                                } else if (snapshot.connectionState ==
                                    ConnectionState.none) {
                                  return Text("No data");
                                }
                                return CircularProgressIndicator();
                              }),
                          Padding(padding: const EdgeInsets.all(8.0)),
                          InkWell(
                            onTap: () {
                              Get.toNamed('/editinfo');
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                height: Get.height * 0.04,
                                width: Get.width * 0.2,
                                color: kaccentColor,
                                child: 'Edit'
                                    .text
                                    .color(Colors.white)
                                    .makeCentered(),
                              ),
                            ),
                          ),
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
            'My announcements'
                .text
                .minFontSize(18)
                .letterSpacing(1)
                .bold
                .makeCentered(),
            Column(
              children: [
                for (int i = 0; i < myAnns.length; i++) myAnns[i],
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<String> getGiverName() async {
    final DocumentSnapshot doc = await collectionRef.doc(user!.uid).get().then(
      (value) {
        name = value.data()!['name'];
        throw "";
      },
    );
    return name;
  }

  Future<String> getGiverUsername() async {
    final DocumentSnapshot doc = await collectionRef.doc(user!.uid).get().then(
      (value) {
        username = value.data()!['username'];
        throw "";
      },
    );
    return username;
  }

  Future<String> getGiverBio() async {
    final DocumentSnapshot doc = await collectionRef.doc(user!.uid).get().then(
      (value) {
        bio = value.data()!['bio'];
        throw "";
      },
    );
    return bio;
  }

  Future<String> getGiverProfilePic() async {
    final DocumentSnapshot doc = await collectionRef.doc(user!.uid).get().then(
      (value) {
        profileImage = value.data()!['profileImage'];
        throw "";
      },
    );
    return profileImage;
  }

  void sendGiverId() {
    setState(() {
      final response_send = http
          .post(Uri.parse(url),
              body: json.encode({
                'giverId': user!.uid,
              }))
          .then((value) {
        print('Done');
      });
    });
  }

  List<Widget> getTheData() {
    setState(() {
      var response = http.get(Uri.parse(url2)).then((response) {
        myAnns.clear();
        var decoded = json.decode(response.body) as Map<String, dynamic>;

        print(decoded);

        for (int i = 1; i < 3; i++) {
          String strI = i.toString();
          annId = decoded[strI][0][0].toString();
          name = decoded[strI][1][0];
          username = decoded[strI][2][0];
          annText = decoded[strI][4][0];
          giverId = decoded[strI][5][0];
          annUploadDate = decoded[strI][6][0];

          myAnns.add(MyWishWidget(
            wId: annId,
            name: name,
            username: username,
            wishText: annText,
            profileImage: 'assets/init_pic.png',
            wishUploadTime: annUploadDate,
          ));
        }
      });
    });
    return myAnns;
  }
}
