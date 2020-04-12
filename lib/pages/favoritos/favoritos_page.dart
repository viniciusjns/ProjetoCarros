import 'package:carros/main.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_bloc.dart';
import 'package:carros/pages/carro/carros_listview.dart';
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

  FavoritosBloc favoritosBloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    favoritosBloc = Provider.of<FavoritosBloc>(context, listen: false);
    favoritosBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _body() {
    return StreamBuilder(
      stream: favoritosBloc.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
//        if (snapshot.hasError) {
////          return TextError("Erro ao carregar carros favoritados");
//        }
//
//        if (!snapshot.hasData) {
//          return TextError("Não há carros favoritados");
//        }

        List<Carro> carros = snapshot.data;
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarrosListView(carros),
        );
      },
    );
  }

  Future<void> _onRefresh() {
    return favoritosBloc.fetch();
  }
}
