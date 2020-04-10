import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/simple_bloc.dart';
import 'package:carros/pages/carro/carro_dao.dart';
import 'package:carros/pages/favoritos/favorito_service.dart';
import 'package:carros/utils/network.dart';

class FavoritosBloc extends SimpleBloc<List<Carro>> {
  fetch() async {
    try {
      List<Carro> carros = await FavoritoService.getCarros();

      add(carros);
      return carros;
    } catch (error) {
      addError(error);
    }
  }
}
