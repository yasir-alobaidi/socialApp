import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wish_wall/models/wishermodel.dart';
import 'package:wish_wall/screens/main/search.dart';
import 'package:wish_wall/widgets/msg_textfield.dart';
import 'package:wish_wall/widgets/single_message.dart';

import '../../models/givermodel.dart';

class ChatScreen extends StatelessWidget {
  final Wisher wisherCurrentUser = Wisher();
  final Giver giverCurrentUser = Giver();

  final String otherUserId;
  final String otherUserName;

  ChatScreen(
      {Key? key,
      wisherCurrentUser,
      giverCurrentUser,
      required this.otherUserId,
      required this.otherUserName})
      : super(key: key);

  final curUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.pink,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text(otherUserName), Container()],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: StreamBuilder(
                    stream: curUser!.displayName == 'Wisher'
                        ? FirebaseFirestore.instance
                            .collection('Wishers_Accounts')
                            .doc(curUser!.uid)
                            .collection('messages')
                            .doc(otherUserId)
                            .collection('chats')
                            .orderBy('date', descending: true)
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection('Givers_Accounts')
                            .doc(curUser!.uid)
                            .collection('messages')
                            .doc(otherUserId)
                            .collection('chats')
                            .orderBy('date', descending: true)
                            .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.docs.length < 1) {
                          return const Center(
                            child: Text('Say Hi!'),
                          );
                        }
                        return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          reverse: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            bool isMe = snapshot.data.docs[index]['senderId'] ==
                                curUser!.uid;

                            return Align(
                                alignment: isMe
                                    ? Alignment.topLeft
                                    : Alignment.topRight,
                                child: SingleMessage(
                                    message: snapshot.data.docs[index]
                                        ['message'],
                                    isMe: isMe));
                          },
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ))),
          MessageTextfield(
              currentUserId: curUser!.uid,
              otherUserId: SearchPage.searchedWisherId),
        ],
      ),
    );
  }
}
