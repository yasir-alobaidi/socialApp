import 'package:flutter/material.dart';

class CheckBoxx extends StatefulWidget {
  const CheckBoxx({Key? key, isChecked}) : super(key: key);
  static bool isChecked = false;

  @override
  State<CheckBoxx> createState() => _CheckBoxxState();
}

class _CheckBoxxState extends State<CheckBoxx> {
  
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: CheckBoxx.isChecked,
      onChanged: (val) {
        CheckBoxx.isChecked = val!;
        setState(() {});
      },
    );
  }
}
