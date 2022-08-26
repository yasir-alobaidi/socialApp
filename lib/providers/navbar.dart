import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wish_wall/screens/main/search.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:velocity_x/velocity_x.dart';

class NavBarProvider with ChangeNotifier {
  int _navBarIndex = 2; //initial page : Wishes feed

  int get nBarindex {
    return _navBarIndex;
  }

  void changeNavBarIndex(int value) {
    _navBarIndex = value;
    notifyListeners();
  }

  TextEditingController searchController = TextEditingController();

  Widget getCenteredTopText() {
    switch (_navBarIndex) {
      case 0:
        return 'Notifications'
            .text
            .color(ktxtwhiteColor)
            .minFontSize(20)
            .fontWeight(FontWeight.w600)
             .letterSpacing(1)
            .make();
      case 1:
        // return Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
        //   child: TextFormField(
        //     decoration: const InputDecoration(
        //       border: OutlineInputBorder(
        //         gapPadding: 10,
        //       ),
        //     ),
        //   ),
        // );
        return Container(
          margin: const EdgeInsets.only(top: 10, bottom: 0),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            border:
                Border.all(width: 2.2, color: Colors.white.withOpacity(0.8)),
            borderRadius: BorderRadius.circular(8),
          ),
          height: Get.height * 0.06,
          child: Center(
            child: TextField(
              controller: searchController,
              onChanged: (value){
                SearchPage.searchText = value;
              },
              style:const TextStyle(
                color: Colors.white,
              ),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                //contentPadding: EdgeInsets.only(bottom: 10),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 231, 228, 228),
                  ),
                  border: InputBorder.none),
            ),
          ),
        );
      case 2:
        return 'Wishes Feed'
            .text
            .color(Colors.white)
            .minFontSize(20)
            .fontWeight(FontWeight.w600)
            .letterSpacing(1)
            .make();
      default:
        return 'Chat'
            .text
            .color(Colors.white)
            .minFontSize(20)
            .fontWeight(FontWeight.w600)
             .letterSpacing(1)
            .make();
    }
  }
}
