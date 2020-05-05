import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_udemy_demos/fabricante.dart';

import 'dropdown.dart';

class HelloDropDown2 extends StatefulWidget {
  @override
  _HelloDropDown2State createState() => _HelloDropDown2State();
}

class _HelloDropDown2State extends State<HelloDropDown2> {

  Cor cor = Cor("Preto", Colors.black);

  static final items = [
    Cor("Azul", Colors.blue),
    Cor("Amarelo", Colors.yellow),
    Cor("Verde", Colors.green),
    Cor("Vermelho", Colors.red),
    Cor("Preto", Colors.black)
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
          DropDown<Cor>(items, "Cores", cor, _onCorChanged),
          Text(
            cor != null ? "Cor > ${cor.nome}" : "",
            style: TextStyle(color: cor.color, fontSize: 30),
          )
        ],
      ),
    );
  }

  void _onCorChanged(Cor cor) {
    print("> ${cor.nome}");

    setState(() {
      this.cor = cor;
    });
  }
}

class Cor extends DropDownItem {
  Color color;
  String nome;

  Cor(this.nome, this.color);

  @override
  String text() {
    return nome;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Cor &&
              runtimeType == other.runtimeType &&
              nome == other.nome;

  @override
  int get hashCode => nome.hashCode;
}
