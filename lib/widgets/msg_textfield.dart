import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wish_wall/screens/main/search.dart';

class MessageTextfield extends StatefulWidget {
  final String? currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final User? curUser = FirebaseAuth.instance.currentUser;
  final String? otherUserId = SearchPage.searchedWisherId;

  MessageTextfield({Key? key, currentUserId, otherUserId}) : super(key: key);

  @override
  State<MessageTextfield> createState() => _MessageTextfieldState();
}

class _MessageTextfieldState extends State<MessageTextfield> {
  TextEditingController msgController = TextEditingController();

final collectionRef = FirebaseFirestore.instance.collection('Wishers_Accounts');
String name = '';
  @override
  Widget build(BuildContext context) {
    setState(() {
      getWisherName().then((value) {
        name = value;
      });
    });
    return Container(
        color: Colors.white,
        padding: const EdgeInsetsDirectional.all(8),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: msgController,
              decoration: InputDecoration(
                labelText: "Type your message",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0),
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            )),
            const SizedBox(width: 20),
            GestureDetector(
                onTap: () async {
                  String message = msgController.text;
                  msgController.clear();
                  if (widget.curUser!.displayName == 'Wisher') {
                    await FirebaseFirestore.instance
                        .collection('Wishers_Accounts')
                        .doc(widget.currentUserId)
                        .collection('messages')
                        .doc(widget.otherUserId)
                        .collection('chats')
                        .add({
                      'senderId': widget.currentUserId,
                      'receiverId': widget.otherUserId,
                      'message': message,
                      'type': 'text',
                      'date': FieldValue.serverTimestamp()
                    }).then((value) {
                      FirebaseFirestore.instance
                          .collection('Wishers_Accounts')
                          .doc(widget.currentUserId)
                          .collection('messages')
                          .doc(widget.otherUserId)
                          .set({
                        'last_msg': message,
                      });
                    });
                    await FirebaseFirestore.instance
                        .collection('Wishers_Accounts')
                        .doc(widget.otherUserId)
                        .collection('messages')
                        .doc(widget.currentUserId)
                        .collection('chats')
                        .add({
                      'senderId': widget.currentUserId,
                      'receiverId': widget.otherUserId,
                      'message': message,
                      'type': 'text',
                      'date': FieldValue.serverTimestamp()
                    }).then((value) {
                      FirebaseFirestore.instance
                          .collection('Wishers_Accounts')
                          .doc(widget.otherUserId)
                          .collection('messages')
                          .doc(widget.currentUserId)
                          .set({
                        'last_msg': message,
                      });
                    }).then((value){
                      FirebaseFirestore.instance
                        .collection('Wishers_Accounts')
                        .doc(widget.otherUserId)
                        .collection('notifications')
                        .add({
                      'noti_body': name + ' Sent you a message',
                      'noti_type': 'cm',
                      'date': FieldValue.serverTimestamp()});
                    });
                  } else {
                    await FirebaseFirestore.instance
                        .collection('Givers_Accounts')
                        .doc(widget.currentUserId)
                        .collection('messages')
                        .doc(widget.otherUserId)
                        .collection('chats')
                        .add({
                      'senderId': widget.currentUserId,
                      'receiverId': widget.otherUserId,
                      'message': message,
                      'type': 'text',
                      'date': FieldValue.serverTimestamp()
                    }).then((value) {
                      FirebaseFirestore.instance
                          .collection('Givers_Accounts')
                          .doc(widget.currentUserId)
                          .collection('messages')
                          .doc(widget.otherUserId)
                          .set({
                        'last_msg': message,
                      });
                    });
                    await FirebaseFirestore.instance
                        .collection('Wishers_Accounts')
                        .doc(widget.otherUserId)
                        .collection('messages')
                        .doc(widget.currentUserId)
                        .collection('chats')
                        .add({
                      'senderId': widget.currentUserId,
                      'receiverId': widget.otherUserId,
                      'message': message,
                      'type': 'text',
                      'date': FieldValue.serverTimestamp()
                    }).then((value) {
                      FirebaseFirestore.instance
                          .collection('Wishers_Accounts')
                          .doc(widget.otherUserId)
                          .collection('messages')
                          .doc(widget.currentUserId)
                          .set({
                        'last_msg': message,
                      });
                    });

                    
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.pink,
                  ),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                )),
          ],
        ));
  }
   Future<String> getWisherName() async {
    final DocumentSnapshot doc = await collectionRef.doc(widget.currentUserId).get().then(
      (value) {
        name = value.data()!['name'];
        throw ""; //put to avoid error
      },
    );
    return name;
  }
}
