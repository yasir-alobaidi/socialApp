// ignore_for_file: unrelated_type_equality_userTypes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:wish_wall/models/postmodel.dart';
import 'package:wish_wall/widgets/bodyselect.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:wish_wall/widgets/bottom_navbar.dart';
import 'package:wish_wall/widgets/centered_widget.dart';
import 'package:wish_wall/widgets/drawer_giver.dart';
import 'package:wish_wall/widgets/drawer_wisher.dart';
import 'package:wish_wall/widgets/floating_button_wisher.dart';

import '../../models/givermodel.dart';
import '../../models/wishermodel.dart';
import '../../widgets/floating_button_giver.dart';

class WrapperManager extends StatelessWidget {
  WrapperManager({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final user = FirebaseAuth.instance
      .currentUser; //used when signed-in is successful, firebase knows which user is signedin therfore getting that user

  Wisher wr = Wisher();
  Giver gr = Giver();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kbgColor,
      appBar: AppBar(
        backgroundColor: kmainColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: GestureDetector(
            onTap: () => _scaffoldKey.currentState?.openDrawer(),
            child: CircleAvatar(
              backgroundColor: Colors.pink.shade200,
              child: CircleAvatar(
                backgroundImage: user?.displayName == 'Wisher'
                    ? AssetImage(wr.profileImage)
                    : AssetImage(gr.profileImage),
                radius: 22,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: const CustomCenterWidget(),
        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                'assets/main_icon.png',
                color: ktxtwhiteColor,
              ),
            ),
          ),
        ],
      ),
      body: BodyWidget(),
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: user?.displayName == 'Wisher'
          ? const CustomFloatingActionButtonWisher()
          : const CustomFloatingActionButtonGiver(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      drawer: user?.displayName == 'Wisher'
          ? CustomDrawerWisher()
          : const CustomDrawerGiver(),
    );
  }
}
