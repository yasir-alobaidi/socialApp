// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wish_wall/models/postmodel.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class PostAnnouncementScreen extends StatefulWidget {
  const PostAnnouncementScreen({Key? key}) : super(key: key);
  static TextEditingController annController = TextEditingController();

  @override
  State<PostAnnouncementScreen> createState() => _PostAnnouncementScreenState();
}

String giverId = FirebaseAuth.instance.currentUser!.uid;
var dateFormatter = DateFormat('dd/MM/yyyy -').add_Hm();
var datetimeNow = DateTime.now();
String annUploadDate = dateFormatter.format(datetimeNow);
String annText = PostAnnouncementScreen.annController.text;

class _PostAnnouncementScreenState extends State<PostAnnouncementScreen> {
  String final_giverId = giverId;
  String final_annText = annText;
  String final_annUploadDate = annUploadDate;

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
    return Scaffold(
      backgroundColor: kbgColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: 'Post an announcement'.text.size(18).letterSpacing(1).make(),
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
                    hintText: 'Make an announcement 📣',
                  ),
                  controller: PostAnnouncementScreen.annController,
                  onSaved: (value) {
                    annText = value!;
                  },
                ),
              ),
              Container(
                width: Get.width * 0.7,
                height: Get.height * 0.1,
                padding: const EdgeInsets.only(
                  bottom: 30,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    _savingData();

                    final url = 'http://10.0.2.2:5000/ann';

                    final response_save = await http
                        .post(Uri.parse(url),
                            body: json.encode({
                              'giverId': giverId,
                              'annText': annText,
                              'annUploadDate': annUploadDate,
                            }))
                        .then(((value) {
                      final snackBar = SnackBar(
                        content: Text('Your announcement has been posted! '),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Get.back();
                    }));
                    PostAnnouncementScreen.annController.clear();
                  },
                  child: 'Post!'
                      .text
                      .minFontSize(20)
                      .fontWeight(FontWeight.w500)
                      .make(),
                ),
              ),
              SizedBox(
                height: Get.height * 0.025,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
