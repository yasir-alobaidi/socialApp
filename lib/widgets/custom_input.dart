import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomInput extends StatelessWidget {
  CustomInput(
      {Key? key,
      required this.title,
      this.isPassword = false,
      required this.written_text})
      : super(key: key);
  bool isPassword;
  String title;
  TextEditingController written_text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: title.text.make(),
        ),
        TextFormField(
          controller: written_text,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
          obscureText: isPassword,
        ),
      ],
    );
  }
}
