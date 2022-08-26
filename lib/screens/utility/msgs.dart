










////////////////////////////////////////////////////////////////////
///
///
///                 WE DON'T NEED THIS PAGE
///
///
////////////////////////////////////////////////////////////////////




















import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wish_wall/models/usermodel.dart';
import 'package:wish_wall/providers/inbox_provider.dart';
import 'package:wish_wall/widgets/inputtext.dart';
import 'package:wish_wall/widgets/msgbox.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class MsgsScreen extends StatelessWidget {
  MsgsScreen({Key? key}) : super(key: key);

  TextEditingController msgController = TextEditingController();





  @override
  Widget build(BuildContext context) {
    
    final UserModel _userinboxmodel = Get.arguments;
    var providerinbox = Provider.of<InboxProvider>(context);
    var msgs = providerinbox.getInboxList;
    void addmsgtolist() {
      String msg = msgController.text;
      if (msg.isEmpty) {
        return;
      } else {
        providerinbox.addtoInboxList(msg);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 25,
              //backgroundImage: NetworkImage(_userinboxmodel.profileImage),
            ),
          )
        ],
        title: _userinboxmodel.name.text.make(),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Consumer<InboxProvider>(
              builder: ((context, inboxprovider, _) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  height: Get.height * 0.8,
                  color: Colors.white10,
                  child: ListView.builder(
                    itemBuilder: ((context, index) {
                      return MsgBox(
                          name: _userinboxmodel.name, msg: msgs[index]);
                    }),
                    itemCount: msgs.length,
                  ),
                );
              }),
            ),
            CustomTextInputWidget(
              msgController: msgController,
              performFunc: addmsgtolist,
            ),
          ],
        ),
      ),
    );
  }
}
