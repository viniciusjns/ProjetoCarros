import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carro/carro_form_page.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/pages/carro/carros_page.dart';
import 'package:carros/pages/favoritos/favoritos_page.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/utils/prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _initTabs();
  }

  _initTabs() async {
    int tabIdx = await Prefs.getInt("tabIdx");

    _tabController = TabController(length: 4, vsync: this);

    setState(() {
      _tabController.index = tabIdx;
    });

    _tabController.addListener(() {
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: _tabController == null
            ? null
            : TabBar(controller: _tabController, tabs: [
                Tab(
                  text: "Clássicos",
                  icon: Icon(Icons.directions_car),
                ),
                Tab(
                  text: "Esportivos",
                  icon: Icon(Icons.directions_car),
                ),
                Tab(
                  text: "Luxo",
                  icon: Icon(Icons.directions_car),
                ),
                Tab(
                  text: "Favoritos",
                  icon: Icon(Icons.favorite),
                ),
              ]),
      ),
      body: _tabController == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                CarrosPage(TipoCarro.classicos),
                CarrosPage(TipoCarro.esportivos),
                CarrosPage(TipoCarro.luxo),
                FavoritosPage(),
              ],
            ),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onClickAddCarro,
      ),
    );
  }

  void _onClickAddCarro() {
    push(context, CarroFormPage());
  }
}
