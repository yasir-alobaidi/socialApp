import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wish_wall/providers/navbar.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final navbarProvider = Provider.of<NavBarProvider>(context);
    return AnimatedBottomNavigationBar(
        activeColor: Colors.white,
        inactiveColor: Color.fromARGB(255, 228, 228, 228),
        backgroundColor: kmainColor,
        elevation: 5,
        iconSize: 30,
        icons: const [
          Icons.notifications,
          Icons.search_rounded,
          Icons.home_rounded,
          CupertinoIcons.chat_bubble_2,
        ],
        activeIndex: navbarProvider.nBarindex,
        gapLocation: GapLocation.end,
        leftCornerRadius: 15,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (val) {
          navbarProvider.changeNavBarIndex(val);
        });
  }
}
