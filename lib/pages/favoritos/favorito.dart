import 'package:carros/pages/carro/carro.dart';
import 'package:carros/utils/sql/entity.dart';

class Favorito extends Entity {

  int _id;
  String _nome;

  Favorito.fromCarro(Carro carro) {
    this._id = carro.id;
    this._nome = carro.nome;
  }

  Favorito.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _nome = json['nome'];
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['nome'] = this._nome;
    return data;
  }

}