import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_udemy_demos/fabricante.dart';

import 'dropdown.dart';

class HelloDropDownFabricante extends StatefulWidget {
  @override
  _HelloDropDownFabricanteState createState() =>
      _HelloDropDownFabricanteState();
}

class _HelloDropDownFabricanteState extends State<HelloDropDownFabricante> {
  Fabricante fabricante;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DropDown Fabricante"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          FutureBuilder<List<Fabricante>>(
              initialData: [],
              future: FabricanteService.getFabricantes(),
              builder: (context, snapshot) {

                List<Fabricante> lista = snapshot.data;

                return DropDown<Fabricante>(lista, "Fabricantes", fabricante, _onFabricanteChanged);
              }),
          Text(
            fabricante != null ? "Fabricante > ${fabricante.nome}" : "",
            style: TextStyle(color: Colors.black, fontSize: 30),
          )
        ],
      ),
    );
  }

  void _onFabricanteChanged(Fabricante f) {
    print("> ${f.nome} > ${f.id}");

    setState(() {
      this.fabricante = f;
    });
  }
}

