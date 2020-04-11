import 'package:flutter/material.dart';

import 'nav.dart';



alert(BuildContext context, String msg, {Function callback}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    if (callback != null) {
                      callback();
                    } else {
                      pop(context);
                    }
                  },
                  child: Text("OK")),
            ],
          ),
        );
      });
}