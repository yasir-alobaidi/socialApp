import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wish_wall/providers/navbar.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:wish_wall/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'providers/posts.dart';
import 'package:flutter/scheduler.dart'
    show timeDilation; //used to slow down the animationss
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  timeDilation = 1.5;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routingClass = RoutingPages();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => NavBarProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PostsProvider(),
          ),
        ],
        child: GetMaterialApp(
          theme: ThemeData(primarySwatch: kmainColor),
          debugShowCheckedModeBanner: false,
          initialRoute: '/splashpage',
          getPages: routingClass.pages,
        ),
      ),
    );
  }
}
