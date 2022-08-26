// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyPage extends StatefulWidget {
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {

  final auth = FirebaseAuth.instance;
  User? user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser;
    user?.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 3), (timer) { 
    checkEmailVerified();
  });
    super.initState();
  }
  
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 241, 249),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: CircularProgressIndicator(),),
          Padding(padding: EdgeInsets.only(bottom: 15)),
          Text("We sent you something :P please verify your email! ;)", style: TextStyle(color: Colors.pink)),
          TextButton(onPressed: (){
            user?.sendEmailVerification();
          }, child: Text("Resend email"))
        ],
      )
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user!.reload();
    if(user!.emailVerified)
    {
      timer.cancel();
      Get.offAndToNamed('/wrapper');
    }
  }

}