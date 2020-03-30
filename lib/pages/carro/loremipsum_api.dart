import 'dart:async';
import 'package:carros/pages/carro/simple_bloc.dart';
import 'package:http/http.dart' as http;

class LoremipsumBloc extends SimpleBloc<String> {

  static String lorim;

  fetch() async {
    try {
      String text = lorim ?? await LoremipsumApi.getLoremipsum();
      lorim = text;
      add(text);
    } catch (error) {
      addError(error);
    }
  }
}

class LoremipsumApi {

  static Future<String> getLoremipsum() async {
    var url = "https://loripsum.net/api";

    print("GET > $url");

    var response = await http.get(url);

    String text = response.body;

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");

    return text;
  }
}