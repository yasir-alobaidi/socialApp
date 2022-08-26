import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wish_wall/models/usermodel.dart';
import 'package:wish_wall/screens/main/chat_screen.dart';
import 'package:wish_wall/screens/main/notifications.dart';
import 'package:wish_wall/screens/main/post_wish.dart';
import 'package:wish_wall/screens/main/search.dart';
import 'package:wish_wall/widgets/inbox_card.dart';

class InboxPage extends StatefulWidget {
  InboxPage({Key? key}) : super(key: key);
  static String otherId = '';
  static String name = '';
  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;

  String pressedName = '';
  String pressedId = '';

  onSearch() async {
    await _firestore
        .collection('Wishers_Accounts')
        .where('name', isEqualTo: InboxCard.name) //inbox name
        .get()
        .then((value) {
      setState(() {
        value.docs.forEach((element) {
          pressedName = element.data()['name'];
          print('skrrrt' + pressedName);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 238, 243),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Wishers_Accounts')
                      .orderBy('birthdate')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: false,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          InboxCard.name = snapshot.data.docs[index]['name'];
                          InboxCard.username = snapshot.data.docs[index]['username'];
                          bool isMe =
                              snapshot.data.docs[index]['id'] == user!.uid;
                          if (!isMe) {
                            return InkWell(
                              onTap: () async {
                                await onSearch();
                                await getInfo().then((value) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                            otherUserName: snapshot
                                                .data.docs[index]['name'],
                                            otherUserId:
                                                SearchPage.searchedWisherId)),
                                  );
                                });
                              },
                              child: InboxCard(
                                  name: snapshot.data.docs[index]['name'],
                                  username: snapshot.data.docs[index]
                                      ['username']),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ))),
      ],
    );
  }

  Future<String> getInfo() async {
    InboxPage.otherId = await _firestore
        .collection('Wishers_Accounts')
        .where('name', isEqualTo: InboxCard.name)
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == InboxCard.name) {
            i++;
            InboxPage.otherId = value.docs[i].data()['id'];
            SearchPage.searchedWisherId = InboxPage.otherId;
          }
        });
        print('pressed ID: ' + InboxPage.otherId);
      });
      return SearchPage.searchedWisherId;
    });
    InboxPage.name = await _firestore
        .collection('Wishers_Accounts')
        .where('name', isEqualTo: InboxCard.name) //inboxcard name
        .get()
        .then((value) {
      setState(() {
        int i = -1;
        value.docs.forEach((element) {
          if (element.data()['name'] == InboxCard.name) {
            i++;
            InboxPage.name = value.docs[i].data()['name'];
          }
        });
        print('pressed name: ' + InboxPage.name);
      });
      return InboxPage.name;
    });
    return 'yooooo';
  }
}
