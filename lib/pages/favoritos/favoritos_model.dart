import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/favoritos/favorito_service.dart';
import 'package:flutter/material.dart';

class FavoritosModel extends ChangeNotifier {
  List<Carro> carros = [];

  void getCarros() async {
    carros = await FavoritoService.getCarros();

    notifyListeners();
  }
}