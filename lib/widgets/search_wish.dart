import 'package:flutter/material.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchWish extends StatelessWidget {
  const SearchWish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kaccentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: ktxtwhiteColor,
                  child: null, //user's profile of the owner of the searched wish
                ),
                Padding(padding: const EdgeInsets.only(left: 5), child: '@username'.text.size(10).make())
              ],
            ),
          ),
          Container(height: 200, alignment: Alignment.center, padding: const EdgeInsets.all(10), child: 'weeeellll...if i had to wish for something...i guess i can have an ice-cream cone? what? don\'t judge..'.text.size(10).maxLines(4).overflow(TextOverflow.ellipsis).make(),)
        ],
      ),
    );
  }
}
