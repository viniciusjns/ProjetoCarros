import 'dart:convert' as convert;

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/favoritos/carro_dao.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final classicos = "classicos";
  static final esportivos = "esportivos";
  static final luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipoCarro) async {
    try {

      Usuario user = await Usuario.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.token}"
      };

      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipoCarro';
      print("GET > $url");
      var response = await http.get(url, headers: headers);
      String json = response.body;

      List list = convert.json.decode(json);

      final carros = list.map((c) => Carro.fromJson(c)).toList();

      return carros;
    } catch (error) {
      print(error);
      throw error;
    }

  }
}