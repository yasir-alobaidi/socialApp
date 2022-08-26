// ignore_for_file: must_be_immutable, unused_local_variable, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wish_wall/models/wishermodel.dart';
import 'package:wish_wall/utils/constants.dart';
import 'package:wish_wall/widgets/checkbox.dart';
import 'package:wish_wall/widgets/custom_input.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPageWisher extends StatefulWidget {
  const SignUpPageWisher({Key? key}) : super(key: key);

  @override
  _SignUpPageWisherState createState() => _SignUpPageWisherState();
}

class _SignUpPageWisherState extends State<SignUpPageWisher> {
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
  TextEditingController birthdate = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController phone_no = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();

  String selectedCountry = 'Select country';
  DateTime selectedDate = DateTime.now();
  int? selectedRadGender = 1; //0 = female, 1 = male
  String wisherGender = "";

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: 'Sign Up'.text.minFontSize(18).make(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.toNamed('/signuppage_giver');
                                },
                                child: 'Click here'
                                    .text
                                    .underline
                                    .color(Color.fromARGB(255, 4, 25, 219))
                                    .make()),
                            ' to Sign up as a Giver'.text.make()
                          ],
                        )),
                  ],
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
                              side: const BorderSide(
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
                  padding: const EdgeInsets.only(left: 2, bottom: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Birthdate *'.text.make(),
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
                      _selectDate(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                        ),
                        Icon(FontAwesomeIcons.cake, size: 15)
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    'Gender:'.text.make(),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 5)),
                ToggleSwitch(
                  minWidth: 90.0,
                  initialLabelIndex: 2,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.white24,
                  inactiveFgColor: Colors.black,
                  totalSwitches: 2,
                  labels: const ['Female', 'Male'],
                  icons: const [FontAwesomeIcons.venus, FontAwesomeIcons.mars],
                  activeBgColors: const [
                    [Colors.pink],
                    [Colors.pink]
                  ],
                  onToggle: (index) {
                    selectedRadGender = index;
                    if (selectedRadGender == 0) {
                      wisherGender = "Female";
                    } else {
                      wisherGender = "Male";
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomInput(
                  written_text: phone_no,
                  title: 'Phone Number',
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
                  title: 'Confim Password *',
                  isPassword: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CheckBoxx(),
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
                  onPressed: () {
                    if (full_name.text.isEmpty ||
                        username.text.isEmpty ||
                        email.text.isEmpty ||
                        password.text.isEmpty ||
                        selectedCountry.isEmpty ||
                        selectedDate.toString().isEmpty) {
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
                          .then((value) => Get.offAllNamed('/verifypage'));
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

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }

  Future signUp({String? email, String? password}) async {
    await _auth
        .createUserWithEmailAndPassword(
            email: this.email.text, password: this.password.text)
        .then((value) => addWisherToFirestore(
            displayName: 'Wisher',
            name: full_name.text.toString(),
            username: username.text.toString(),
            gender: wisherGender,
            country: selectedCountry,
            birthdate: selectedDate.toString(),
            email: this.email.text.toString(),
            phoneNo: phone_no.text.toString()));

    this._auth.currentUser!.updateDisplayName('Wisher');
  }

  Future addWisherToFirestore(
      {required String displayName,
      required String name,
      required String username,
      required String gender,
      required String email,
      required String country,
      required String birthdate,
      String? phoneNo}) async {
    final userDoc = FirebaseFirestore.instance
        .collection('Wishers_Accounts')
        .doc(_auth.currentUser!.uid);

    final wisher = Wisher(
      displayName: 'Wisher',
      id: _auth.currentUser!.uid,
      name: full_name.text.toString(),
      username: this.username.text.toString(),
      gender: wisherGender,
      country: selectedCountry,
      birthdate: selectedDate.toString(),
      phoneNo: phone_no.text.toString(),
    );

    final json = wisher.toJson();
    await userDoc.set(json);
  }
}
