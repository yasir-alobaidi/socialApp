// ignore_for_file: avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wish_wall/providers/navbar.dart';
import 'package:wish_wall/widgets/search_profile.dart';
import 'package:wish_wall/widgets/search_wish.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchPage extends StatefulWidget {
  static String searchText = '';

  static String searchedWisherId = '';
  static String searchedWisherName = '';
  static String searchedWisherUsername = '';
  static String searchedWisherBio = '';
  static String searchedWisherProfileImage = '';
  static String searchedWisherDisplayName = '';

  static String searchedGiverId = '';
  static String searchedGiverName = '';
  static String searchedGiverUsername = '';
  static String searchedGiverBio = '';
  static String searchedGiverProfileImage = '';
  static String searchedGiverDisplayName = '';

  const SearchPage({Key? key, searchText}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Map<String, dynamic>? userMap;
  bool isLoading = false;

  String wisherName = '';
  String wisherUsername = '';

  String giverName = '';
  String giverUsername = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  onSearchWisher() async {
    await _firestore
        .collection('Wishers_Accounts')
        .where('name', isEqualTo: SearchPage.searchText)
        .get()
        .then((value) {
      //userMap = value.docs[0].data();
      //print(userMap);
      setState(() {
        value.docs.forEach((element) {
          wisherName = element.data()['name'];
          wisherUsername = element.data()['username'];
        });
      });
    });
  }

  onSearchGiver() async {
    await _firestore
        .collection('Givers_Accounts')
        .where('name', isEqualTo: SearchPage.searchText)
        .get()
        .then((value) {
      //userMap = value.docs[0].data();
      //print(userMap);
      setState(() {
        value.docs.forEach((element) {
          giverName = element.data()['name'];
          giverUsername = element.data()['username'];
        });
      });
    });
  }

  Widget searchResWisher = Container();
  Widget searchResGiver = Container();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(23),
                        topLeft: Radius.circular(23)),
                  ))),
                  child: 'Search'.text.make(),
                  onPressed: () {
                    setState(() async {
                      await onSearchWisher();
                      await onSearchGiver();
                      if (wisherName != '') {
                        searchResWisher = InkWell(
                            onTap: () async {
                              await getSearchedWisherInfo().then((value) {
                                print("signed in user:");
                                print(user!.displayName);

                                if (user?.displayName == 'Wisher' &&
                                    SearchPage.searchedWisherDisplayName ==
                                        'Wisher') {
                                  Get.toNamed(
                                      '/GviewWprofilepage'); //Wisher vies another non-friend Wisher
                                } else if (user?.displayName == 'Wisher' &&
                                    SearchPage.searchedGiverDisplayName == 'Giver') {
                                  Get.toNamed(
                                      '/WviewGprofilepage'); //Wisher views Giver
                                } else {
                                  Get.toNamed(
                                      '/GviewWprofilepage'); //if the wisher's is befriended with the current user
                                }
                              });
                            },
                            child: SearchProfile(
                                name: wisherName, username: wisherUsername));
                        wisherName = '';
                        wisherUsername = '';
                      } else {
                        searchResWisher = const Center();
                      }
                      if (giverName != '') {
                        searchResGiver = InkWell(
                            onTap: () async {
                              await getSearchedGiverInfo().then((value) {
                                print("signed in user:");
                                print(user!.displayName);

                                if (user?.displayName == 'Giver' &&
                                    SearchPage.searchedGiverDisplayName == 'Giver') {
                                  Get.toNamed(
                                      '/WviewGprofilepage'); //giver views another giver
                                } else if (user?.displayName == 'Giver' &&
                                    SearchPage.searchedWisherDisplayName ==
                                        'Wisher') {
                                  Get.toNamed('/GviewWprofilepage');
                                } else if (user?.displayName == 'Wisher' &&
                                    SearchPage.searchedGiverDisplayName == 'Giver') {
                                  Get.toNamed('/WviewGprofilepage');
                                } else {
                                  Get.toNamed(
                                      '/GviewWprofilepage'); //if the wisher's is befriended with the current user
                                }
                              });
                            },
                            child: SearchProfile(
                                name: giverName, username: giverUsername));
                        giverName = '';
                        giverUsername = '';
                      } else {
                        searchResGiver = const Center();
                      }
                    });
                  }),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            children: [searchResWisher, searchResGiver],
          ),
        ),
      ],
    );
  }

  Future<String> getSearchedWisherInfo() async {
    SearchPage.searchedWisherId = await _firestore
        .collection('Wishers_Accounts')
        .where('name', isEqualTo: SearchPage.searchText)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == SearchPage.searchText) {
            i++;
            SearchPage.searchedWisherId = value.docs[i].data()['id'];
          }
        });
        print(SearchPage.searchedWisherId);
      });
      return SearchPage.searchedWisherId;
    });
    SearchPage.searchedWisherDisplayName = await _firestore
        .collection('Wishers_Accounts')
        .where('name', isEqualTo: SearchPage.searchText)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == SearchPage.searchText) {
            i++;
            SearchPage.searchedWisherDisplayName =
                value.docs[i].data()['displayName'];
          }
        });
        print(SearchPage.searchedWisherDisplayName);
      });
      return SearchPage.searchedWisherDisplayName;
    });
    SearchPage.searchedWisherName = await _firestore
        .collection('Wishers_Accounts')
        .where('name', isEqualTo: SearchPage.searchText)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == SearchPage.searchText) {
            i++;
            SearchPage.searchedWisherName = value.docs[i].data()['name'];
          }
        });
        print(SearchPage.searchedWisherName);
      });
      return SearchPage.searchedWisherName;
    });
    SearchPage.searchedWisherUsername = await _firestore
        .collection('Wishers_Accounts')
        .where('name', isEqualTo: SearchPage.searchText)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == SearchPage.searchText) {
            i++;
            SearchPage.searchedWisherUsername =
                value.docs[i].data()['username'];
          }
        });
        print(SearchPage.searchedWisherUsername);
      });
      return SearchPage.searchedWisherUsername;
    });
    SearchPage.searchedWisherBio = await _firestore
        .collection('Wishers_Accounts')
        .where('name', isEqualTo: SearchPage.searchText)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == SearchPage.searchText) {
            i++;
            SearchPage.searchedWisherBio = value.docs[i].data()['bio'];
          }
        });
        print(SearchPage.searchedWisherBio);
      });
      return SearchPage.searchedWisherBio;
    });
    SearchPage.searchedWisherProfileImage = await _firestore
        .collection('Wishers_Accounts')
        .where('name', isEqualTo: SearchPage.searchText)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == SearchPage.searchText) {
            i++;
            SearchPage.searchedWisherProfileImage =
                value.docs[i].data()['profileImage'];
          }
        });
      });
      return SearchPage.searchedWisherProfileImage;
    });
    return '';
  }

  Future<String> getSearchedGiverInfo() async {
    SearchPage.searchedGiverId = await _firestore
        .collection('Givers_Accounts')
        .where('name', isEqualTo: SearchPage.searchText)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == SearchPage.searchText) {
            i++;
            SearchPage.searchedGiverId = value.docs[i].data()['id'];
          }
        });
        print(SearchPage.searchedGiverId);
      });
      return SearchPage.searchedGiverId;
    });
    SearchPage.searchedGiverDisplayName = await _firestore
        .collection('Givers_Accounts')
        .where('name', isEqualTo: SearchPage.searchText)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == SearchPage.searchText) {
            i++;
            SearchPage.searchedGiverDisplayName =
                value.docs[i].data()['displayName'];
          }
        });
        print(SearchPage.searchedGiverDisplayName);
      });
      return SearchPage.searchedGiverDisplayName;
    });
    SearchPage.searchedGiverName = await _firestore
        .collection('Givers_Accounts')
        .where('name', isEqualTo: SearchPage.searchText)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == SearchPage.searchText) {
            i++;
            SearchPage.searchedGiverName = value.docs[i].data()['name'];
          }
        });
        print(SearchPage.searchedGiverName);
      });
      return SearchPage.searchedGiverName;
    });
    SearchPage.searchedGiverUsername = await _firestore
        .collection('Givers_Accounts')
        .where('name', isEqualTo: SearchPage.searchText)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == SearchPage.searchText) {
            i++;
            SearchPage.searchedGiverUsername = value.docs[i].data()['username'];
          }
        });
        print(SearchPage.searchedGiverUsername);
      });
      return SearchPage.searchedGiverUsername;
    });
    SearchPage.searchedGiverBio = await _firestore
        .collection('Givers_Accounts')
        .where('name', isEqualTo: SearchPage.searchText)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == SearchPage.searchText) {
            i++;
            SearchPage.searchedGiverBio = value.docs[i].data()['bio'];
          }
        });
        print(SearchPage.searchedGiverBio);
      });
      return SearchPage.searchedGiverBio;
    });
    SearchPage.searchedGiverProfileImage = await _firestore
        .collection('Givers_Accounts')
        .where('name', isEqualTo: SearchPage.searchText)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == SearchPage.searchText) {
            i++;
            SearchPage.searchedGiverProfileImage =
                value.docs[i].data()['profileImage'];
          }
        });
      });
      return SearchPage.searchedGiverProfileImage;
    });
    return '';
  }
}
