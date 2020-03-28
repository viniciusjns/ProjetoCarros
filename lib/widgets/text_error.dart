import 'package:flutter/material.dart';

class TextError extends StatelessWidget {

  String _msg;

  TextError(this._msg);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _msg,
        style: TextStyle(
          color: Colors.red,
          fontSize: 18,
        ),
      ),
    );
  }
}
