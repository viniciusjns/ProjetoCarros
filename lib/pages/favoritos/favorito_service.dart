import 'package:carros/main.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_dao.dart';
import 'package:carros/pages/favoritos/favorito_dao.dart';
import 'package:carros/pages/favoritos/favoritos_bloc.dart';
import 'package:carros/pages/favoritos/favoritos_model.dart';
import 'package:provider/provider.dart';

import 'favorito.dart';

class FavoritoService {
  static Future<bool> favoritar(context, Carro carro) async {
    Favorito favorito = Favorito.fromCarro(carro);
    FavoritosModel favoritosModel = Provider.of<FavoritosModel>(context, listen: false);

    final dao = FavoritoDAO();
    final exists = await dao.exists(carro.id);

    if (exists) {
      dao.delete(carro.id);
      favoritosModel.getCarros();
      return false;
    } else {
      dao.save(favorito);
      favoritosModel.getCarros();
      return true;
    }
  }

  static Future<List<Carro>> getCarros() async {
    String sql = "select * from carro c, favorito f where c.id = f.id";
    return CarroDAO().query(sql);
  }

  static Future<bool> isFavorito(Carro carro) async {
    final dao = FavoritoDAO();
    final exists = await dao.exists(carro.id);
    return exists;
  }
}