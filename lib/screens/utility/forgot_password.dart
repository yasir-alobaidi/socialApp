// ignore_for_file: prefer_const_constructors, camel_case_types, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:velocity_x/velocity_x.dart';

class forgotPass extends StatefulWidget {
  @override
  _forgotPassState createState() => _forgotPassState();
}

class _forgotPassState extends State<forgotPass> {
  TextEditingController email = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

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
            controller: email,
            obscureText: false,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
              ),
              labelText: 'Email',
              //hintText: 'Your password'
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 15)),
          SizedBox(
            width: 190,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                resetPassword();
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

  Future resetPassword() async {
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());
      const snackBar =
          SnackBar(content: Text('A Reset Password email has been sent!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Get.offAllNamed('/signinpage');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(e.message as SnackBar);
      Get.back();
    }
  }
}
