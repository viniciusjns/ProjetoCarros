import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  String label;
  String hint;
  bool password;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyBoardType;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode nextFocus;

  AppTextField(this.label, this.hint,
      {this.password = false,
      this.controller,
      this.validator,
      this.keyBoardType,
      this.textInputAction,
      this.focusNode,
      this.nextFocus});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: password,
      validator: validator,
      keyboardType: keyBoardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) FocusScope.of(context).requestFocus(nextFocus);
      },
      style: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: label,
          labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 16)),
    );
  }
}
