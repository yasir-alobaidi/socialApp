// ignore_for_file: prefer_const_constructors, camel_case_types, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class radio_button extends StatefulWidget {
  @override
  _radio_buttonState createState() => _radio_buttonState();
}

class _radio_buttonState extends State<radio_button> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int? selectedRadio;
    String? labelText;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              value: 1,
              groupValue: selectedRadio,
              activeColor: Colors.pink,
              onChanged: (value) {
                setState(() {
                  selectedRadio = value as int?;
                });
              }),
          Text(
            labelText!,
          ),
        ],
      ),
    );
  }
}




// RadioGroup<String>.builder(
//   groupValue: _verticalGroupValue,
//   onChanged: (value) => setState(() {
//     _verticalGroupValue = value;
//   }),
//   items: _status,
//   itemBuilder: (item) => RadioButtonBuilder(
//     item,
//   ),
// ),

// RadioButton(
//   description: "Text alignment right",
//   value: "Text alignment right",
//   groupValue: _singleValue,
//   onChanged: (value) => setState(
//     () => _singleValue = value,
//   ),
// ),