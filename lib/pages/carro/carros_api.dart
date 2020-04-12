import 'dart:convert' as convert;
import 'dart:io';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/http_helper.dart' as http;
import 'package:carros/utils/upload_service.dart';

class TipoCarro {
  static final classicos = "classicos";
  static final esportivos = "esportivos";
  static final luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipoCarro) async {
    try {
      var url =
          'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipoCarro';
      print("GET > $url");
      var response = await http.get(url);
      String json = response.body;

      List list = convert.json.decode(json);

      final carros = list.map((c) => Carro.fromJson(c)).toList();

      return carros;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  static Future<ApiResponse<bool>> save(Carro carro, File file) async {
    try {
      if (file != null) {
        final response = await UploadService.upload(file);
        if (response.ok) {
          String urlFoto = response.result;
          carro.urlFoto = urlFoto;
        }
      }

      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/';
      if (carro.id != null) {
        url += "${carro.id}";
      }

      print("POST > $url");

      String json = carro.toJson();

      print("JSON > $json");

      var response = await (carro.id == null
          ? http.post(url, body: json)
          : http.put(url, body: json));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map mapResponse = convert.json.decode(response.body);
        Carro c = Carro.fromJson(mapResponse);
        print("Novo carro: ${c.id}");

        return ApiResponse.ok(true);
      }

      if (response.body == null || response.body.isEmpty) {
        return ApiResponse.error("Não foi possível salvar o carro");
      }

      Map mapResponse = convert.json.decode(response.body);

      return ApiResponse.error(mapResponse["error"]);
    } catch (error) {
      print(error);
      return ApiResponse.error("Não foi possível salvar o carro");
    }
  }

  static delete(Carro carro) async {
    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/${carro.id}';

      print("DELETE > $url");

      var response = await (http.delete(url));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return ApiResponse.ok(true);
      }

      return ApiResponse.error("Não foi possível deletar o carro");
    } catch (error) {
      print(error);
      return ApiResponse.error("Não foi possível deletar o carro");
    }
  }
}
