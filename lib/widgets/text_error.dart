import 'package:flutter/material.dart';

class TextError extends StatelessWidget {

  String _msg;
  Function onPressed;

  TextError(this._msg, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: this.onPressed,
        child: Text(
          _msg,
          style: TextStyle(
            color: Colors.red,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
