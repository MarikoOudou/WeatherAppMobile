import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ModelRepo {
  final String url = "";

  void getHttp() async {
    try {
      var response = await Dio().get('http://www.google.com');
      print(response);
    } catch (e) {
      print(e);
    }
  }

  getClient() async {
    var client = http.Client();
    try {
      var response = await client.post(
          Uri.https('example.com', 'whatsit/create'),
          body: {'name': 'doodle', 'color': 'blue'});
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      var uri = Uri.parse(decodedResponse['uri'] as String);
      print(await client.get(uri));
    } finally {
      client.close();
    }
  }
}
