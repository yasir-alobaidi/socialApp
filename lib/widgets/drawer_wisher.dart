// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wish_wall/models/postmodel.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wish_wall/models/wishermodel.dart';

class CustomDrawerWisher extends StatefulWidget {
  CustomDrawerWisher({Key? key}) : super(key: key);

  @override
  State<CustomDrawerWisher> createState() => _CustomDrawerWisherState();
}

class _CustomDrawerWisherState extends State<CustomDrawerWisher> {
  final user = FirebaseAuth.instance.currentUser;

  final collectionRef =
      FirebaseFirestore.instance.collection('Wishers_Accounts');
  String name = "";
  String username = "";
  String profileImage = '';

  @override
  Widget build(BuildContext context) {
    Wisher wr = Wisher();

    //for the displayed data...(user info [name, bio...etc])
    setState(() {
      getWisherName().then((value) {
        name = value;
      });
      getWisherUsername().then((value) {
        username = value;
      });
      getWisherProfilePic().then((value) {
        profileImage = value;
      });
    });

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(75), bottomRight: Radius.circular(75))),
      height: Get.height,
      width: Get.width * 0.6,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                        future: getWisherProfilePic(),
                        builder: (context, snapshot) {
                          return Center(
                            child: Container(
                              width: Get.width * 0.3,
                              height: Get.width * 0.3,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(profileImage),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.pink.shade200,
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                    //offset: const Offset(3, 2),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, bottom: 3, left: 10),
                      child: FutureBuilder(
                          future: getWisherName(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Text(name, style: TextStyle(fontSize: 16));
                            } else if (snapshot.connectionState ==
                                ConnectionState.none) {
                              return Text("No data");
                            }
                            return CircularProgressIndicator();
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 10),
                      child: FutureBuilder(
                          future: getWisherUsername(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Text('@' + username,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300));
                            } else if (snapshot.connectionState ==
                                ConnectionState.none) {
                              return Text("No data");
                            }
                            return CircularProgressIndicator();
                          }),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    InkWell(
                      onTap: () {
                        //if(user!.uid == user.uid) //shitty statement BRUH unnecessary if statement brrruuhhhh
                        Get.toNamed('/wisherprofilepage');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 20, left: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.person, size: 20),
                            ),
                            'Profile'.text.wordSpacing(3).make(),
                          ],
                        ),
                      ),
                    ),
                    /* ######Uncomment this when you've made friends system#######
                    InkWell(
                      onTap: () {
                        Get.toNamed('/friendspage');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 20, left: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.people, size: 20),
                            ),
                            'Friends List'.text.wordSpacing(3).make(),
                          ],
                        ),
                      ),
                    ),*/
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 20, left: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.contact_support, size: 20),
                            ),
                            'Support'.text.wordSpacing(3).make(),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/settingspage_wisher');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 20, left: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.settings, size: 20),
                            ),
                            'Settings'.text.wordSpacing(3).make(),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut().then((value) {
                          Get.offAllNamed('/splashpage');
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 20, left: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.logout_outlined,
                                  size: 20, color: Colors.pink),
                            ),
                            'Sign Out'
                                .text
                                .color(kaccentColor)
                                .wordSpacing(3)
                                .make(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getAllWishers() {
    collectionRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        print(doc.data());
      });
    });
  }

  getWisherByID() async {
    final DocumentSnapshot doc = await collectionRef.doc(user!.uid).get();
    print(doc.data());
  }

  getData() async {
    DocumentSnapshot<Map<String, dynamic>> userData =
        await collectionRef.doc(user!.uid).get();

    collectionRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        print(snapshot.docs.elementAt(1).toString());
      });
    });
  }

  Future<String> getWisherName() async {
    final DocumentSnapshot doc = await collectionRef.doc(user!.uid).get().then(
      (value) {
        name = value.data()!['name'];
        throw "";
      },
    );
    return name; //put to avoid error
  }

  Future<String> getWisherUsername() async {
    final DocumentSnapshot doc = await collectionRef.doc(user!.uid).get().then(
      (value) {
        username = value.data()!['username'];
        throw "";
      },
    );
    return username; //put to avoid error
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
}
