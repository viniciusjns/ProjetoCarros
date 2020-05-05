import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_udemy_demos/dropdown_string.dart';

class HelloDropDown1 extends StatefulWidget {
  @override
  _HelloDropDown1State createState() => _HelloDropDown1State();
}

class _HelloDropDown1State extends State<HelloDropDown1> {
  Color color = Colors.black;
  String nomeCor;

  final items = [
    "Azul",
    "Amarelo",
    "Verde",
    "Vermelho",
    "Preto",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DropDown"),
      ),
      body: _body(),
    );
  }

  _body() {

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          DropDownString(items, "Cores", nomeCor, _onCorChanged),
          Text(
            "Cor > $nomeCor",
            style: TextStyle(color: color, fontSize: 30),
          )
        ],
      ),
    );
  }

  void _onCorChanged(String value) {
    print("> $value");

    setState(() {
      nomeCor = value;
      if ("Azul" == value) {
        color = Colors.blue;
      } else if ("Amarelo" == value) {
        color = Colors.yellow;
      } else if ("Verde" == value) {
        color = Colors.green;
      }else if ("Vermelho" == value) {
        color = Colors.red;
      }else if ("Preto" == value) {
        color = Colors.black;
      }
    });
  }
}