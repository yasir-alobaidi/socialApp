// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wish_wall/models/postmodel.dart';
import 'package:wish_wall/models/usermodel.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'package:wish_wall/widgets/wish-announcement_widget.dart';
import 'package:http/http.dart' as http;

import '../../widgets/fulfillable_wish.dart';

class GiverHomePage extends StatefulWidget {
  const GiverHomePage({Key? key}) : super(key: key);

  @override
  State<GiverHomePage> createState() => _GiverHomePageState();
}

String name = '';
String username = '';
String wisherId = '';
String wishText = '';
String wishPrivacy = '';
String wishUploadDate = '';
String wishStatus = '';
String wishCategory = '';

String gender = '';
String birthDate = '';
String country = '';
String emailAddress = '';
String pNr = '';

String gName = '';
String gUsername = '';
String giverId = '';
String annText = '';
String annUploadDate = '';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final url = 'http://10.0.2.2:5000/giver_view';
final url2 = 'http://10.0.2.2:5000/view_annc';

List<Widget> wishes = [];
List<Widget> anns = [];

class _GiverHomePageState extends State<GiverHomePage> {
  @override
  void initState() {
    super.initState();
    getTheData();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getTheData();
    });
    String? selectedDateSort;
    //String? selectedCategorySort;

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 238, 243),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 2, 25, 0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(23)),
                        ))),
                        child: 'Sort'.text.make(),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => StatefulBuilder(
                                    builder: (context, setState) => AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25.0))),
                                      backgroundColor: const Color.fromARGB(
                                          255, 255, 247, 250),
                                      content: Container(
                                        height: 120,
                                        child: Column(children: [
                                          Container(
                                              width: 100,
                                              height: 20,
                                              child:
                                                  'Sort by date:'.text.make()),
                                          Container(
                                            width: Get.width - 200,
                                            height: 50,
                                            child: Row(
                                              children: [
                                                Radio(
                                                    value: 'newest',
                                                    groupValue:
                                                        selectedDateSort,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedDateSort =
                                                            value as String;
                                                        print(selectedDateSort);
                                                      });
                                                    }),
                                                'By date (newest)'
                                                    .text
                                                    .size(13)
                                                    .make(),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: Get.width - 200,
                                            height: 50,
                                            child: Row(
                                              children: [
                                                Radio(
                                                    value: 'oldest',
                                                    groupValue:
                                                        selectedDateSort,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedDateSort =
                                                            value as String;
                                                        print(selectedDateSort);
                                                      });
                                                    }),
                                                'By date (oldest)'
                                                    .text
                                                    .size(13)
                                                    .make(),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text('Cancel')),
                                        TextButton(
                                            onPressed: () {
                                              //perform the sort function
                                            },
                                            child: Text('Sort')),
                                      ],
                                    ),
                                  ));
                        }),
                  ),
                ],
              ),
              for (int i = 0; i < wishes.length; i++) wishes[i],
            ],
          ),
        ));
  }

  List<Widget> getTheData() {
    setState(() {
      var response = http.get(Uri.parse(url)).then((response) {
        wishes.clear();
        var decoded = json.decode(response.body) as Map<String, dynamic>;

        print(decoded);

        for (int i = 1; i < 7; i++) {
          String strI = i.toString();
          wisherId = decoded[strI][0][0];
          name = decoded[strI][1][0];
          username = decoded[strI][2][0];
          wishText = decoded[strI][3][0];
          wishPrivacy = decoded[strI][4][0];
          wishStatus = decoded[strI][5][0];
          wishUploadDate = decoded[strI][6][0];

          wishes.add(FulfillableWish(
              name: name,
              username: username,
              wishText: wishText,
              profileImage: 'assets/init_pic.png',
              wishUploadTime: wishUploadDate,
              gender: gender,
              birthDate: birthDate,
              country: country,
              emailAddress: emailAddress,
              pNr: pNr));
        }
      });
    });
    return wishes;
  }

  List<Widget> getAnnouncemenets() {
    setState(() {
      var response = http.get(Uri.parse(url2)).then((response) {
        anns.clear();
        var decoded = json.decode(response.body) as Map<String, dynamic>;

        print(decoded);

        for (int i = 1; i < 3; i++) {
          String strI = i.toString();
          gName = decoded[strI][0][0];
          gUsername = decoded[strI][1][0];
          annText = decoded[strI][2][0];
          giverId = decoded[strI][3][0];
          annUploadDate = decoded[strI][4][0];

          anns.add(WishWidget(
            name: gName,
            username: gUsername,
            wishText: annText,
            profileImage: 'assets/init_pic.png',
            wishUploadTime: annUploadDate,
          ));
        }
      });
    });
    return anns;
  }
}
