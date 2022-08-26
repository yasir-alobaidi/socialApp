// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:wish_wall/widgets/checkbox.dart';
import 'package:wish_wall/widgets/custom_input.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/givermodel.dart';

class SignUpPageGiver extends StatefulWidget {
  @override
  _SignUpPageGiverState createState() => _SignUpPageGiverState();
}

class _SignUpPageGiverState extends State<SignUpPageGiver> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  TextEditingController full_name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();

  String selectedCountry = 'Select country';

  bool? electronicsChecked = false;
  bool? vgChecked = false;
  bool isApproved = false;

  List<String> categories = [];

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        leading: BackButton(color: Colors.pink),
      ),
      body: SafeArea(
        child: Container(
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
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: 'Wish Wall'
                      .text
                      .minFontSize(24)
                      .fontWeight(FontWeight.w600)
                      .maxFontSize(26)
                      .make(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: 'Giver\'s Sign Up'.text.minFontSize(18).make(),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomInput(
                  written_text: full_name,
                  title: 'Full Name *',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomInput(
                  written_text: username,
                  title: 'Username *',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomInput(
                  written_text: email,
                  title: 'Email Address *',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomInput(
                  written_text: password,
                  title: 'Password *',
                  isPassword: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomInput(
                  written_text: confirm_password,
                  title: 'Confirm Password *',
                  isPassword: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, bottom: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Country *'.text.make(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 80, 80, 80)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.white.withOpacity(0.1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                  color: Color.fromARGB(255, 140, 140, 140)))),
                    ),
                    onPressed: () {
                      showCountryPicker(
                        context: context,
                        onSelect: (Country country) {
                          setState(
                            () {
                              selectedCountry = country.name;
                            },
                          );
                          //selectedCountryCode = country.phoneCode;
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedCountry,
                        ),
                        const Icon(FontAwesomeIcons.flag, size: 15)
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CheckBoxx(isChecked: false),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Row(
                            children: [
                              'I agree to'
                                  .text
                                  .fontWeight(FontWeight.w600)
                                  .make(),
                              ' Wish Wall Terms & Conditions'
                                  .text
                                  .color(
                                    const Color.fromARGB(255, 4, 25, 219),
                                  )
                                  .fontWeight(FontWeight.w600)
                                  .make(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23.0),
                  ))),
                  onPressed: () async {
                    if (full_name.text.isEmpty ||
                        username.text.isEmpty ||
                        email.text.isEmpty ||
                        password.text.isEmpty ||
                        selectedCountry.isEmpty) {
                      if (password.text != confirm_password.text) {
                        final snackBar = SnackBar(
                          content: Text('Passwords don\'t match'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      if (!CheckBoxx.isChecked) {
                        final snackBar = SnackBar(
                          content: Text(
                              'You must agree with our terms & conditions'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      final snackBar = SnackBar(
                        content: Text('Please fill in the required fields'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      signUp(
                              email: this.email.text,
                              password: this.password.text)
                          .then(_showMyDialog());
                    }
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: 'Sign Up'
                          .text
                          .minFontSize(18)
                          .fontWeight(FontWeight.w600)
                          .make(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      'Already have an account?'.text.minFontSize(16).make(),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: (() => Get.toNamed('/signinpage')),
                        child: 'Sign In'
                            .text
                            .fontWeight(FontWeight.w500)
                            .minFontSize(16)
                            .color(
                              const Color.fromARGB(255, 8, 12, 236),
                            )
                            .make(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dynamic _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 24,
          title: const Text('Sent!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Your request is being reviewed by our team.'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                _auth.currentUser!.sendEmailVerification();
                Get.offAndToNamed('/signinpage');
              },
            ),
          ],
        );
      },
    );
  }

  Future signUp({String? email, String? password}) async {
    await _auth
        .createUserWithEmailAndPassword(
            email: this.email.text, password: this.password.text)
        .then((value) => {
              addGiverToFirestore(
                  displayName: 'Giver',
                  name: full_name.text,
                  username: username.text,
                  country: selectedCountry,
                  categories: categories)
            });
    this._auth.currentUser!.updateDisplayName('Giver');
  }

  Future addGiverToFirestore({
    required String displayName,
    required String name,
    required String username,
    required String country,
    //required String email,
    required List<String> categories,
  }) async {
    final userDoc = FirebaseFirestore.instance
        .collection('Givers_Accounts')
        .doc(_auth.currentUser!.uid);

    final giver = Giver(
      displayName: 'Giver',
      id: _auth.currentUser!.uid,
      name: full_name.text.toString(),
      username: this.username.text.toString(),
      country: selectedCountry,
      categories: this.categories,
      isApproved: isApproved,
    );

    final json = giver.toJson();
    await userDoc.set(json);
  }
}
