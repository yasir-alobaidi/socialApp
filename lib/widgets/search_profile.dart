
import 'package:flutter/material.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchProfile extends StatelessWidget {
  String name = '';
  String username = '';
  SearchProfile({Key? key, required this.name, required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: kaccentColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                spreadRadius: 2,
                blurRadius: 8,
                color: Color.fromARGB(111, 255, 64, 128),
                offset: Offset(1, 5))
          ]),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            height: 110,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
          Positioned(
            top: 13,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: ktxtwhiteColor,
                  child: const Icon(Icons.person),
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                Text(name, style: const TextStyle(color: Colors.white)),
                Text('@' + username, style: const TextStyle(color: Colors.white)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
