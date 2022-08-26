// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wish_wall/models/postmodel.dart';
import 'package:wish_wall/models/usermodel.dart';
import 'package:wish_wall/providers/posts.dart';
import 'package:wish_wall/screens/main/post_wish.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:wish_wall/widgets/wish-announcement_widget.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../widgets/fulfillable_wish.dart';

class WisherHomePage extends StatefulWidget {
  WisherHomePage({Key? key}) : super(key: key);

  @override
  State<WisherHomePage> createState() => _WisherHomePageState();
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

String gName = '';
String gUsername = '';
String giverId = '';
String annText = '';
String annUploadDate = '';

final url = 'http://10.0.2.2:5000/public_view';
final url2 = 'http://10.0.2.2:5000/view_annc';

List<Widget> wishes = [];
List<Widget> anns = [];

class _WisherHomePageState extends State<WisherHomePage> {
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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 238, 243),
      body: ListView(children: [
        for (int i = 0; i < wishes.length; i++) wishes[i],
      ]),
    );
  }

  List<Widget> getTheData() {
    setState(() {
      var response = http.get(Uri.parse(url)).then((response) {
        wishes.clear();
        var decoded = json.decode(response.body) as Map<String, dynamic>;

        print(decoded);

        for (double i = 1; i < 7; i++) {
          String strI = i.toString();
          wisherId = decoded[strI][0][0];
          name = decoded[strI][1][0];
          username = decoded[strI][2][0];
          wishText = decoded[strI][3][0];
          wishPrivacy = decoded[strI][4][0];
          wishStatus = decoded[strI][5][0];
          wishUploadDate = decoded[strI][6][0];

          wishes.add(WishWidget(
              name: name,
              username: username,
              wishText: wishText,
              profileImage: 'assets/init_pic.png',
              wishUploadTime: wishUploadDate));
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
