import 'package:flutter/material.dart';

class SingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;

  const SingleMessage({Key? key, required this.message, required this.isMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxWidth: 200),
          decoration: BoxDecoration(
            boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(112, 158, 158, 158),
              blurRadius: 10,
              spreadRadius: 3,
              offset: Offset(0,5),
            ),
          ],
            color: isMe ? Colors.pink: Colors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Text(message, style: const TextStyle(color: Colors.white)),
          
        ),
    ],);
  }
}
