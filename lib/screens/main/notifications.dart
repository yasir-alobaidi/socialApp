import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wish_wall/widgets/friend_card.dart';
import 'package:wish_wall/widgets/notification_card.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

bool friendReq = false;

List<NotificationCard> items = [];
final user = FirebaseAuth.instance.currentUser;
final notiRef = FirebaseFirestore.instance
    .collection('Wishers_Accounts')
    .doc(user!.uid)
    .collection('notifications');
final collectionRef = FirebaseFirestore.instance.collection('Wishers_Accounts');
String name = '';

var curUser = FirebaseAuth.instance.currentUser;

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      getWisherName().then((value) {
        name = value;
      });
    });

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
                  child: 'Clear all'.text.make(),
                  onPressed: () {
                    deleteNestedSubcollections(curUser!.uid);
                  }),
            ),
          ],
        ),
        Expanded(
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 238, 243),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: StreamBuilder(
                  stream: curUser!.displayName == 'Wisher'
                      ? FirebaseFirestore.instance
                          .collection('Wishers_Accounts')
                          .doc(curUser!.uid)
                          .collection('notifications')
                          .orderBy('date', descending: true)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('Givers_Accounts')
                          .doc(curUser!.uid)
                          .collection('notifications')
                          .orderBy('date', descending: true)
                          .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.docs.length < 1) {
                        return Center(
                          child: 'No notifications atm ;('
                              .text
                              .color(Colors.pink)
                              .bold
                              .make(),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: false,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (snapshot.data.docs[index]['noti_type'] == 'cm') {
                            return NotificationCard(
                                CupertinoIcons.chat_bubble,
                                Colors.pink,
                                snapshot.data.docs[index]['noti_body']);
                          } else {
                            return NotificationCard(
                                CupertinoIcons.wand_stars,
                                Colors.yellow,
                                snapshot.data.docs[index]['noti_body']);
                          }
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ))),
      ],
    );

    // );
  }

  Future<String> getWisherName() async {
    final DocumentSnapshot doc = await collectionRef.doc(user!.uid).get().then(
      (value) {
        name = value.data()!['name'];
        throw ""; //put to avoid error
      },
    );
    return name;
  }

  void deleteNestedSubcollections(String id) {
    Future<QuerySnapshot> notifications =
        collectionRef.doc(id).collection("notifications").get().then((value) {
      value.docs.one((element) {
        Future<void> notifications = collectionRef
            .doc(id)
            .collection("notifications")
            .doc(element.id)
            .delete();
        return false;
      });
      throw '';
    });
  }
}









//NotificationCard(
  //        Icons.star,
    //      Colors.yellow,
      //    'Your wish is chosen to be fulfilled!',
        //  InkWell(
          //  child: Container(),
          //),
          //InkWell(
            //onTap: () {},
            //child: const Icon(Icons.remove, color: Colors.pink),
          //),
        //),
        //-------------------------------------------------------------
        //NotificationCard(
          //  Icons.person_add,
            //Colors.pink,
            //'Friend Request: @username',
            //InkWell(
              //onTap: () {},
              //child: const Icon(Icons.check, color: Colors.pink),
  //          ),
    //        InkWell(
          //    onTap: () {},
      //        child: const Icon(Icons.remove, color: Colors.pink),
        //    ))