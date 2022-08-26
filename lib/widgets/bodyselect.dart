import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wish_wall/providers/navbar.dart';
import 'package:wish_wall/screens/main/giver_home.dart';

import 'package:provider/provider.dart';

import '../screens/main/inbox.dart';
import '../screens/main/notifications.dart';
import '../screens/main/search.dart';
import '../screens/main/wisher_home.dart';

class BodyWidget extends StatelessWidget {
  BodyWidget({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final navbarProvider = Provider.of<NavBarProvider>(context);
    switch (navbarProvider.nBarindex) {
      case 0:
        return const NotificationsPage();
      case 1:
        return const SearchPage();
      case 2:
        if (user!.displayName == 'Wisher') {
          return WisherHomePage();
        } else {
          return const GiverHomePage();
        }
      default:
        return InboxPage();
    }
  }
}
