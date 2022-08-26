// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wish_wall/models/postmodel.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PostWishScreen extends StatefulWidget {
  const PostWishScreen({Key? key}) : super(key: key);
  static bool selectedWState =
      true; //false = a private Wish, true = a public wish
  static TextEditingController wishController = TextEditingController();

  @override
  State<PostWishScreen> createState() => _PostWishScreenState();
}

final user = FirebaseAuth.instance.currentUser;

final collectionRef = FirebaseFirestore.instance.collection('Wishers_Accounts');

String name = '';
String username = '';
String wisherId =
    FirebaseAuth.instance.currentUser!.uid; //get the current user uid
String wishPrivacy = 'public';
var dateFormatter = DateFormat('dd/MM/yyyy -').add_Hm();
var datetimeNow = DateTime.now();
String wishUploadDate = dateFormatter.format(datetimeNow);
String wishText = PostWishScreen.wishController.text;

class _PostWishScreenState extends State<PostWishScreen> {
  //vars to save all the data in
  String final_wisherId = wisherId;
  String final_wishText = wishText;
  String final_wishUploadDate = wishUploadDate;
  String final_wishPrivacy = wishPrivacy;

  //key for the form key
  final _formkey = GlobalKey<FormState>();

  Future<void> _savingData() async {
    final validation = _formkey.currentState!.validate();
    if (!validation) {
      return;
    }
    _formkey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getWisherName().then((value) {
        name = value;
      });
      getWisherUsername().then((value) {
        username = value;
      });
    });
    return Scaffold(
      backgroundColor: kbgColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: 'Make a Wish!'.text.letterSpacing(2.5).make(),
      ),
      body: SizedBox(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: TextFormField(
                  maxLines: 5,
                  maxLength: 140,
                  decoration: const InputDecoration(
                    hintText: 'What is it you wish for? ミ★',
                  ),
                  controller: PostWishScreen.wishController,
                  onSaved: (value) {
                    wishText = value!;
                  },
                ),
              ),
              //private/public wish state Toggle/Switch
              AnimatedToggleSwitch<bool>.dual(
                  current: PostWishScreen.selectedWState,
                  first: true,
                  second: false,
                  dif: 20.0,
                  innerColor: kbgColor,
                  borderColor: Colors.transparent,
                  //borderWidth: 0.3,
                  height: 55, //coulb be 40
                  animationOffset: Offset(20.0, 0),
                  clipAnimation: false,
                  onChanged: (b) => setState(() {
                        PostWishScreen.selectedWState = b;
                        if (PostWishScreen.selectedWState == false) {
                          wishPrivacy = 'private';
                        } else {
                          wishPrivacy = 'public';
                        }
                        final_wishPrivacy = wishPrivacy;
                      }),
                  colorBuilder: (b) => b ? kbgColor : kbgColor,
                  iconBuilder: (value) =>
                      value ? Icon(FontAwesomeIcons.earth) : Icon(Icons.lock),
                  textBuilder: (value) => value
                      ? Center(
                          child: DefaultTextStyle(
                          style: TextStyle(fontSize: 15, color: Colors.black),
                          child: Text(
                            'Public',
                          ),
                        ))
                      : Center(
                          child: DefaultTextStyle(
                          style: TextStyle(fontSize: 15, color: Colors.black),
                          child: Text(
                            'Private',
                          ),
                        ))),
              Padding(padding: EdgeInsets.only(bottom: 20)),
              Container(
                width: Get.width * 0.7,
                height: Get.height * 0.1,
                padding: const EdgeInsets.only(
                  bottom: 30,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    _savingData();

                    final url = 'http://10.0.2.2:5000/wish';

                    final response_save = await http
                        .post(Uri.parse(url),
                            body: json.encode({
                              'wisherId': wisherId,
                              'name': name,
                              'username': username,
                              'wishText': wishText,
                              'wishUploadDate': wishUploadDate,
                              'wishPrivacy': final_wishPrivacy,
                            }))
                        .then(((value) {
                      final snackBar = SnackBar(
                        content: Text('Your wish has been poofed! '),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Get.back();
                    }));
                    PostWishScreen.wishController.clear();
                  },
                  child: 'Poof!'
                      .text
                      .minFontSize(20)
                      .fontWeight(FontWeight.w500)
                      .make(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getWisherName() async {
    final DocumentSnapshot doc = await collectionRef.doc(user!.uid).get().then(
      (value) {
        name = value.data()!['name'];
        throw "";
      },
    );
    return name;
  }

  Future<String> getWisherUsername() async {
    final DocumentSnapshot doc = await collectionRef.doc(user!.uid).get().then(
      (value) {
        username = value.data()!['username'];
        throw "";
      },
    );
    return username;
  }
}
