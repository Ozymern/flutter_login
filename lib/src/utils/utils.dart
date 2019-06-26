import 'package:flutter/material.dart';

void showAlert(BuildContext context, String message) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Info'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss alert dialog
            },
          ),
        ],
      );
    },
  );
}
