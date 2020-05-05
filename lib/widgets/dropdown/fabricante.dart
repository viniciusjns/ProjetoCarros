import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'dropdown.dart';

class Fabricante extends DropDownItem {
  int id;
  String nome;

  Fabricante.fromJson(Map<String, dynamic> json) :
      id = json["id"] as int,
      nome = json["fabricante"];

  @override
  String toString() {
    return 'Fabricante{id: $id, fabricante: $nome}';
  }

  @override
  String text() {
    return nome;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Fabricante &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              nome == other.nome;

  @override
  int get hashCode =>
      id.hashCode ^
      nome.hashCode;
}

class FabricanteService {

  static Future<List<Fabricante>> getFabricantes() async {

    String url = "http://www.mocky.io/v2/5cff04eb3200005b0045f2b9";

    final response = await http.get(url);
    final json = response.body;
    final map = convert.json.decode(json);

    List<Fabricante> fabricantes = map.map<Fabricante>
      ((json) => Fabricante.fromJson(json)).toList();

//    List<String> nomes = fabricantes.map<String>
//        ((fabricante) => fabricante.nome).toList();
//    print("nomes: $nomes");

    return fabricantes;
  }
}