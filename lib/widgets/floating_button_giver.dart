import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wish_wall/providers/posts.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomFloatingActionButtonGiver extends StatelessWidget {
  const CustomFloatingActionButtonGiver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: kMainColor,
        onPressed: () {
          Get.toNamed('/postannouncement');
        },
        child: const Icon(Icons.post_add_rounded));
  }
}
