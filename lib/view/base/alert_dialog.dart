
import 'package:flutter/material.dart';


class CustomDialog {
static dialog({required BuildContext context ,  required String title  , required String message   ,
  required  bool isCancelBtn ,Function? onOkClick , Function? onCancelClick})  {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
              onOkClick!();
            },
          ),
          isCancelBtn? TextButton(
            child:  const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
              onCancelClick!();
            },
          ): const SizedBox(),
        ],
      );
    },
  );
}
    }

