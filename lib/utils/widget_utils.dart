import 'package:flutter/material.dart';

// Widgets/Styles
var buttonStyle = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.black))));

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

void showAlertDialog(BuildContext context,
    {String title, String content, Function confirmFunction, int index}) {

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            FlatButton(
                onPressed: () => Navigator.pop(context), child: Text("não")),
            FlatButton(
                onPressed: () {
                  confirmFunction(index);
                  Navigator.pop(context);
                },
                child: Text("sim"))
          ],
        );
      });
}
