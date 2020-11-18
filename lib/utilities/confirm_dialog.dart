import 'package:flutter/material.dart';

showConfirmDialog(BuildContext context,
    {String title,
    String content,
    String textOK,
    String textCancel,
    VoidCallback actionOK,
    VoidCallback actionCancel}) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: textCancel != null ? Text(textCancel) : Text('Cancel'),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      if (actionCancel != null) {
        actionCancel();
      }
    },
  );
  Widget okButton = FlatButton(
    child: textOK != null ? Text(textOK) : Text('OK'),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      if (actionOK != null) {
        actionOK();
      }
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: title != null ? Text(title) : Text('Alert Dialog'),
    content: content != null ? Text(content) : SizedBox(),
    actions: [
      cancelButton,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
