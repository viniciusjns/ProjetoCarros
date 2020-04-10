import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_dao.dart';
import 'package:carros/pages/favoritos/favorito_dao.dart';

import 'favorito.dart';

class FavoritoService {
  static Future<bool> favoritar(Carro carro) async {
    Favorito favorito = Favorito.fromCarro(carro);

    final dao = FavoritoDAO();
    final exists = await dao.exists(carro.id);

    if (exists) {
      dao.delete(carro.id);
      return false;
    } else {
      dao.save(favorito);
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