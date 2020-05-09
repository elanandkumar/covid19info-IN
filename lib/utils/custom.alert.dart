import 'package:flutter/material.dart';

class CustomAlert {
  static void show(BuildContext context, String error) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Error!!"),
          content: error != ''
              ? Text("Something went wrong! [$error]")
              : Text("Something went wrong!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Close",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondaryVariant),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
