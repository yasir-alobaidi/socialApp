// ignore_for_file: prefer_const_constructors, camel_case_types, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:velocity_x/velocity_x.dart';

class editEmail extends StatefulWidget {
  @override
  _editEmailState createState() => _editEmailState();
}

class _editEmailState extends State<editEmail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final user = FirebaseAuth.instance.currentUser;

  TextEditingController curEmail = TextEditingController();
  TextEditingController newEmail = TextEditingController();

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
            controller: curEmail,
            obscureText: false,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
              ),
              labelText: 'Current Email',
            ),
          ),
          TextField(
            controller: newEmail,
            obscureText: false,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
              ),
              labelText: 'New Email',
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 15)),
          SizedBox(
            width: 190,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                if(user?.email == curEmail.text) {
                  changeEmail().then((value) {
                  const snackBar = SnackBar(
                      content: Text('A verification email has been sent to your new address!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Get.back();
                });
                }
              },
              style: ElevatedButton.styleFrom(
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

  Future changeEmail() async {
    user!.updateEmail(newEmail.text).then((value) {
      user!.sendEmailVerification();
    });
  }
}
