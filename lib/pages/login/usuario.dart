import 'dart:convert' as convert;
import 'package:carros/utils/prefs.dart';

class Usuario {
  int _id;
  String _login;
  String _nome;
  String _email;
  String _urlFoto;
  String _token;
  List<String> _roles;

  Usuario(
      {int id,
      String login,
      String nome,
      String email,
      String urlFoto,
      String token,
      List<String> roles}) {
    this._id = id;
    this._login = login;
    this._nome = nome;
    this._email = email;
    this._urlFoto = urlFoto;
    this._token = token;
    this._roles = roles;
  }

  int get id => _id;

  set id(int id) => _id = id;

  String get login => _login;

  set login(String login) => _login = login;

  String get nome => _nome;

  set nome(String nome) => _nome = nome;

  String get email => _email;

  set email(String email) => _email = email;

  String get urlFoto => _urlFoto;

  set urlFoto(String urlFoto) => _urlFoto = urlFoto;

  String get token => _token;

  set token(String token) => _token = token;

  List<String> get roles => _roles;

  set roles(List<String> roles) => _roles = roles;

  Usuario.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _login = json['login'];
    _nome = json['nome'];
    _email = json['email'];
    _urlFoto = json['urlFoto'];
    _token = json['token'];
    _roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['login'] = this._login;
    data['nome'] = this._nome;
    data['email'] = this._email;
    data['urlFoto'] = this._urlFoto;
    data['token'] = this._token;
    data['roles'] = this._roles;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("user.prefs", json);
  }

  static void clear() {
    Prefs.setString("user.prefs", "");
  }

  static Future<Usuario> get() async {
    String json = await Prefs.getString("user.prefs");
    if (json.isEmpty)
      return null;
    Map map = convert.json.decode(json);
    Usuario user = Usuario.fromJson(map);
    return user;
  }

  @override
  String toString() {
    return 'Usuario{_id: $_id, _login: $_login, _nome: $_nome, _email: $_email, _urlFoto: $_urlFoto, _token: $_token, _roles: $_roles}';
  }


}
