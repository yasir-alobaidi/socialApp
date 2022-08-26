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
import 'package:http/http.dart' as http;

import '../../models/wishermodel.dart';
import '../../widgets/mywish-myannouncement_widget.dart';

class WisherProfilePage extends StatefulWidget {
  const WisherProfilePage({Key? key}) : super(key: key);

  @override
  State<WisherProfilePage> createState() => _WisherProfilePageState();
}

final user = FirebaseAuth.instance.currentUser;

final collectionRef = FirebaseFirestore.instance.collection('Wishers_Accounts');

final url = 'http://10.0.2.2:5000/wisherid';
final url2 = 'http://10.0.2.2:5000/own_view';

String name = '';
String username = '';
String wishId = '';
String wisherId = '';
String wishText = '';
String wishPrivacy = '';
String wishUploadDate = '';
String wishStatus = '';
String wishCategory = '';
String bio = '';
String profileImage = '';

List<Widget> myShit = [];

class _WisherProfilePageState extends State<WisherProfilePage> {
  @override
  void initState() {
    super.initState();
    sendWisherId();
    getTheData();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      sendWisherId();
      getTheData();
      getWisherName().then((value) {
        name = value;
      });
      getWisherUsername().then((value) {
        username = value;
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
                          future: getWisherProfilePic(),
                          builder: (context, snapshot) {
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
                              future: getWisherName(),
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
                              future: getWisherUsername(),
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
                              future: getWisherBio(),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            /* ####Uncomment this when you've made the friends system#####
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                '13'.text.bold.make(),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                'Friends'
                                    .text
                                    .minFontSize(Get.textScaleFactor)
                                    .make(),
                              ],
                            ),
                            */
                          ),
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
            'My wishes'
                .text
                .minFontSize(18)
                .letterSpacing(1)
                .bold
                .makeCentered(),
            Column(
              children: [
                for (int i = 0; i < myShit.length; i++) myShit[i],
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<String> getWisherName() async {
    final DocumentSnapshot doc = await collectionRef.doc(user!.uid).get().then(
      (value) {
        name = value.data()!['name'];
        throw ""; //put to avoid error
      },
    );
    return name;
  }

  Future<String> getWisherUsername() async {
    final DocumentSnapshot doc = await collectionRef.doc(user!.uid).get().then(
      (value) {
        username = value.data()!['username'];
        throw ""; //put to avoid error
      },
    );
    return username;
  }

  Future<String> getWisherBio() async {
    final DocumentSnapshot doc = await collectionRef.doc(user!.uid).get().then(
      (value) {
        bio = value.data()!['bio'];
        throw ""; //put to avoid error
      },
    );
    return bio;
  }

  Future<String> getWisherProfilePic() async {
    final DocumentSnapshot doc = await collectionRef.doc(user!.uid).get().then(
      (value) {
        profileImage = value.data()!['profileImage'];
        throw ""; //put to avoid error
      },
    );
    return profileImage;
  }

  void sendWisherId() {
    setState(() {
      final response_send = http
          .post(Uri.parse(url),
              body: json.encode({
                'wisherId': user!.uid,
              }))
          .then((value) {
        print('Done');
      });
    });
  }

  List<Widget> getTheData() {
    setState(() {
      var response = http.get(Uri.parse(url2)).then((response) {
        myShit.clear();
        var decoded = json.decode(response.body) as Map<String, dynamic>;

        print(decoded);

        for (double i = 1; i < 4; i++) {
          String strI = i.toString();
          wishId = decoded[strI][0][0].toString();
          wisherId = decoded[strI][1][0];
          name = decoded[strI][2][0];
          username = decoded[strI][3][0];
          wishText = decoded[strI][4][0];
          wishPrivacy = decoded[strI][5][0];
          wishStatus = decoded[strI][6][0];
          wishUploadDate = decoded[strI][7][0];

          myShit.add(MyWishWidget(
            wId: wishId,
            wishPrivacy: wishPrivacy,
            name: name,
            username: username,
            wishText: wishText,
            profileImage: 'assets/init_pic.png',
            wishUploadTime: wishUploadDate,
          ));
        }
        print(myShit);
      });
    });
    return myShit;
  }
}
