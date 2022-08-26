// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../models/usermodel.dart';

class SettingsPageGiver extends StatefulWidget {
  @override
  _SettingsPageGiverState createState() => _SettingsPageGiverState();
}

class _SettingsPageGiverState extends State<SettingsPageGiver> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool recieveNotif = false;
  @override
  Widget build(BuildContext context) {
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
                  height: Get.height * 0.4,
                ),
                Positioned(
                  left: Get.width * 0.2,
                  right: Get.width * 0.2,
                  bottom: 40,
                  child: Column(
                    children: [
                      Icon(
                        Icons.settings,
                        size: 70,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      'Settings'.text.color(Colors.white).bold.size(25).make()
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
            Padding(padding: EdgeInsets.only(bottom: 20)),
            Container(
              height: Get.height * 0.07,
              width: Get.width * 0.73,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Row(
                children: [
                  'App Notifications'.text.size(17).make(),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Switch(
                        activeColor: Colors.pink,
                        value: recieveNotif,
                        onChanged: (value) {
                          setState(() {
                            recieveNotif = value;
                          });
                        }),
                  ),
                ],
              ),
            ),
            Divider(
              indent: 50,
              endIndent: 50,
              thickness: 0.2,
              color: Colors.pink,
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            SizedBox(
              width: 190,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/forgotpass');
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    width: 1,
                    color: Colors.pink,
                  ),
                  primary: Colors.pink, //background color of button
                  elevation: 3, //elevation of button
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(15)),
                  //content padding inside button
                ),
                child: 'Change Password'.text.size(15).make(),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            Divider(
              indent: 50,
              endIndent: 50,
              thickness: 0.2,
              color: Colors.pink,
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            SizedBox(
              width: 190,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/editemail');
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    width: 1,
                    color: Colors.pink,
                  ),
                  primary: Colors.pink, //background color of button
                  elevation: 3, //elevation of button
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(15)),
                  //content padding inside button
                ),
                child: 'Change Email'.text.size(15).make(),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
          ],
        ),
      ),
    );
  }
}
