import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Text buildSharedPrefText(String sharedPrefText) {
  return Text.rich(
    TextSpan(
      text: "SharedPref:  ",
      children: <TextSpan>[
        TextSpan(
            text: sharedPrefText,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Row navigationRow(BuildContext context, String button1, String path1,
    String button2, String path2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      FloatingActionButton.extended(
          onPressed: () => Navigator.pushNamed(context, path1),
          label: Text(button1)),
      const SizedBox(width: 16), // Space between buttons
      FloatingActionButton.extended(
          onPressed: () => Navigator.pushNamed(context, path2),
          label: Text(button2)),
    ],
  );
}

TextFormField inputSharedPref(BuildContext context, TextEditingController textController) {
  return TextFormField(
    controller: textController,
    decoration: const InputDecoration(
      labelText: "Enter something to store in SharedPref",
    ),
    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return "Please enter some text.";
      }
      return null;
    },
  );
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: "SharedPref: $message",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
