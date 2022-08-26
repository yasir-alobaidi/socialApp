import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wish_wall/providers/posts.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomFloatingActionButtonWisher extends StatelessWidget {
  const CustomFloatingActionButtonWisher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: kMainColor,
        onPressed: () {
          Get.toNamed('/postwish');
        },
        child: const Icon(FontAwesomeIcons.wandMagicSparkles));
  }
}
