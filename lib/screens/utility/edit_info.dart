// ignore_for_file: prefer_const_constructors, camel_case_types, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/givermodel.dart';
import '../../models/wishermodel.dart';

class editInfo extends StatefulWidget {
  @override
  _editInfoState createState() => _editInfoState();
}

class _editInfoState extends State<editInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController bio = TextEditingController();

  final snackBar = SnackBar(
    content: Text('Your info has been updated! ;)'),
  );

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: Colors.pink, //HexColor("#E8D8CF"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          TextField(
            controller: name,
            obscureText: false,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
              ),
              labelText: 'Name',
              hintText: "New name",
            ),
          ),
          TextField(
            controller: username,
            obscureText: false,
            decoration: InputDecoration(
                prefixIcon: Icon(CupertinoIcons.at),
                labelText: 'Username',
                hintText: 'New username'),
          ),
          TextField(
            controller: bio,
            maxLength: 100,
            maxLines: 4,
            obscureText: false,
            decoration: InputDecoration(
              prefixIcon: Icon(CupertinoIcons.text_alignleft),
              labelText: 'Bio',
              hintText: 'Your new bio...',
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 15)),
          SizedBox(
            width: 190,
            height: 52,
            child: ElevatedButton(
              onPressed: () async {
                if (user!.displayName == 'Wisher') {
                 await editWisher(
                          name: name.text,
                          username: username.text,
                          bio: bio.text)
                      .then((value) => Get.back());
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  await editGiver(
                          name: name.text,
                          username: username.text,
                          bio: bio.text)
                      .then((value) => Get.back());
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                user!.reload();
              },
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  width: 1,
                  color: HexColor("#E8D8CF"),
                ),
                primary: Colors.pink, //background color of button
                elevation: 3, //elevation of button
                shape: RoundedRectangleBorder(
                    //to set border radius to button
                    borderRadius: BorderRadius.circular(20)),
                //content padding inside button
              ),
              child: 'Submit'.text.size(15).make(),
            ),
          ),
        ]),
      ),
    );
  }

  Future editWisher({
    required String name,
    required String username,
    required String bio,
  }) async {
    final userDoc = FirebaseFirestore.instance
        .collection('Wishers_Accounts')
        .doc(user!.uid);

    final wisher = Wisher(
        name: this.name.text.toString(),
        username: this.username.text.toString(),
        bio: this.bio.text);

    //final json = wisher.toJson();
    await userDoc.update(wisher.editInfo());
  }

  Future editGiver({
    required String name,
    required String username,
    required String bio,
  }) async {
    final userDoc =
        FirebaseFirestore.instance.collection('Givers_Accounts').doc(user!.uid);

    final giver = Giver(
        name: this.name.text.toString(),
        username: this.username.text.toString(),
        bio: this.bio.text);

    //final json = giver.toJson();
    await userDoc.update(giver.editInfo());
  }
}
