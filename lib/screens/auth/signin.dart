// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wish_wall/screens/main/wisher_home.dart';
import 'package:wish_wall/screens/main/wrapper.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:wish_wall/widgets/checkbox.dart';
import 'package:wish_wall/widgets/custom_input.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/wishermodel.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Wisher w = Wisher();

  final User? user = FirebaseAuth.instance.currentUser;

  final collectionRef =
      FirebaseFirestore.instance.collection('Givers_Accounts');

  late bool isApproved;

  @override
  Widget build(BuildContext context) {
    setState(() {
      getGiverApproval().then((value) {
        isApproved = value;
      });
    });

    return Scaffold(
      body: StreamBuilder<User?>(
          initialData: null,
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/main_icon.png',
                        color: kMainColor,
                        scale: 3.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child:
                            'Welcome to Wish Wall'.text.minFontSize(18).make(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.black54,
                                //thickness: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomInput(
                        written_text: email,
                        title: 'Email',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomInput(
                        written_text: password,
                        title: 'Password',
                        isPassword: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 0, 25),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed('/forgotpass');
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: 'Forgot Password?'
                                    .text
                                    .fontWeight(FontWeight.w600)
                                    .make(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            //backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.0),
                        ))),
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email.text, password: password.text)
                                .then((value) {
                              print("nuthinnnnn");
                              if (user!.emailVerified) {
                                print("Email verfied");
                                if (user?.displayName == 'Wisher') {
                                  print("Wisher");
                                  Get.offAllNamed('/wrapper');
                                } else if (user?.displayName == 'Giver') {
                                  print("Giver");
                                  if (isApproved) {
                                    print("Approved");
                                    Get.offAllNamed('/wrapper');
                                  }
                                }
                              }
                            });
                          } on FirebaseAuthException catch (e) {
                            final snackBar = SnackBar(
                              content: Text(e.message.toString()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: 'Sign In'
                                .text
                                .minFontSize(18)
                                .fontWeight(FontWeight.w600)
                                .make(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            'Don\'t have an account?'
                                .text
                                .minFontSize(16)
                                .make(),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (() => Get.toNamed('/signuppage_wisher')),
                        child: 'Sign Up'
                            .text
                            .underline
                            .fontWeight(FontWeight.w500)
                            .minFontSize(16)
                            .color(
                              Color.fromARGB(255, 46, 101, 196),
                            )
                            .make(),
                      ),
                    ],
                  ),
                ));
          }),
    );
  }

  Future<bool> getGiverApproval() async {
    final DocumentSnapshot doc = await collectionRef.doc(user?.uid).get().then(
      (value) {
        isApproved = value.data()?['isApproved'];
        throw ""; //put to avoid error
      },
    );
    return isApproved;
  }
}
