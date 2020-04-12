import 'package:carros/main.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_bloc.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/pages/favoritos/favoritos_model.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'favoritos_bloc.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    FavoritosModel favoritosModel = Provider.of<FavoritosModel>(context, listen: false);
    favoritosModel.getCarros();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _body() {
    FavoritosModel model = Provider.of<FavoritosModel>(context);
    List<Carro> carros = model.carros;

    if (carros.isEmpty) {
      return Center(
        child: TextError("Nenhum carro nos favoritos"),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CarrosListView(carros),
    );

//    return StreamBuilder(
//      stream: favoritosModel.stream,
//      builder: (BuildContext context, AsyncSnapshot snapshot) {
////        if (snapshot.hasError) {
//////          return TextError("Erro ao carregar carros favoritados");
////        }
////
////        if (!snapshot.hasData) {
////          return TextError("Não há carros favoritados");
////        }
//
//        List<Carro> carros = snapshot.data;
//        return RefreshIndicator(
//          onRefresh: _onRefresh,
//          child: CarrosListView(carros),
//        );
//      },
//    );
  }

  Future<List<Carro>> _onRefresh() {
    return Provider.of<FavoritosModel>(context, listen: false).getCarros();
  }
}
