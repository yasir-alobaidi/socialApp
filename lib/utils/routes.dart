import 'package:get/get.dart';
import 'package:wish_wall/main.dart';
import 'package:wish_wall/providers/inbox_provider.dart';
import 'package:wish_wall/screens/auth/signup_wisher.dart';
import 'package:wish_wall/screens/auth/signup_giver.dart';
import 'package:wish_wall/screens/auth/verify.dart';
import 'package:wish_wall/screens/main/WviewG_profile.dart';
import 'package:wish_wall/screens/main/chat_screen.dart';
import 'package:wish_wall/screens/main/friends_list.dart';
import 'package:wish_wall/screens/main/giver_profile.dart';
import 'package:wish_wall/screens/main/giver_home.dart';
import 'package:wish_wall/screens/main/post_announcement.dart';
import 'package:wish_wall/screens/main/settings_wisher.dart';
import 'package:wish_wall/screens/main/WviewW_profile.dart';
import 'package:wish_wall/screens/utility/edit_email.dart';
import 'package:wish_wall/screens/utility/edit_info.dart';
import 'package:wish_wall/screens/utility/forgot_password.dart';

import 'package:wish_wall/screens/utility/msgs.dart';
import 'package:wish_wall/screens/main/post_wish.dart';
import 'package:wish_wall/screens/main/wrapper.dart';
import 'package:wish_wall/screens/splash.dart';

import 'package:provider/provider.dart';

import '../screens/auth/signin.dart';
import '../screens/main/GviewW-Friend_profile.dart';
import '../screens/main/inbox.dart';
import '../screens/main/notifications.dart';
import '../screens/main/wisher_home.dart';
import '../screens/main/wisher_profile.dart';
import '../screens/main/search.dart';
import '../screens/main/settings_giver.dart';

class RoutingPages {
  List<GetPage<dynamic>> pages = [
    GetPage(
      name: '/splashpage',
      page: () => const SplashPage(),
    ),
    GetPage(
      name: '/signinpage',
      page: () => const SignInPage(),
    ),
    GetPage(
      name: '/signuppage_wisher',
      page: () => const SignUpPageWisher(),
    ),
    GetPage(
      name: '/signuppage_giver',
      page: () => SignUpPageGiver(),
    ),
    GetPage(
      name: '/wrapper',
      page: () => WrapperManager(),
    ),
    GetPage(
      name: '/giverhomepage',
      page: () => const GiverHomePage(),
    ),
    GetPage(
      name: '/wisherhomepage',
      page: () => WisherHomePage(),
    ),
    GetPage(
      name: '/postwish',
      page: () => const PostWishScreen(),
    ),
    GetPage(
      name: '/postannouncement',
      page: () => const PostAnnouncementScreen(),
    ),
    GetPage(
      name: '/wisherprofilepage',
      page: () => const WisherProfilePage(),
    ),
    GetPage(
      name: '/giverprofilepage',
      page: () => GiverProfilePage(),
    ),
    GetPage(
      name: '/WviewWprofilepage',
      page: () => WviewWProfilePage(),
    ),
    GetPage(
      name: '/GviewWprofilepage',
      page: () => const GviewWProfilePage(),
    ),
    GetPage(
      name: '/WviewGprofilepage',
      page: () => const WviewGProfilePage(),
    ),
    GetPage(
      name: '/searchpage',
      page: () => const SearchPage(),
    ),
    GetPage(
      name: '/notificationspage',
      page: () => const NotificationsPage(),
    ),
    GetPage(
      name: '/inboxpage',
      page: () => InboxPage(),
    ),
    //GetPage(
      //name: '/msgspage',
      //page: () => ChangeNotifierProvider(
        //  create: (context) => InboxProvider(), child: MsgsScreen()),
    //),
    GetPage(
      name: '/friendspage',
      page: () => const friendsPage(),
    ),
    GetPage(
      name: '/settingspage_wisher',
      page: () => SettingsPageWisher(),
    ),
    GetPage(
      name: '/settingspage_giver',
      page: () => SettingsPageGiver(),
    ),
    GetPage(
      name: '/editinfo',
      page: () => editInfo(),
    ),
    GetPage(
      name: '/editemail',
      page: () => editEmail(),
    ),
    GetPage(
      name: '/forgotpass',
      page: () => forgotPass(),
    ),
    GetPage(
      name: '/verifypage',
      page: () => VerifyPage(),
    ),
    //GetPage(
      //name: '/chatscreen',
      //page: () => ChatScreen(),
    //),
  ];
}
