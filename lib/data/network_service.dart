import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/shared/storage/storage.dart';
import 'package:flutter_application_1/shared/storage/storage_key.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  final baseUrl =
      "http://api.weatherapi.com/v1/current.json?key=62cf002399574239ae4141403221410&q=";

  // final client = Dio();

  Future<dynamic> requestHttpGetData(String path) async {
    final String url = baseUrl + "$path";
    if (kDebugMode) {
      print("URL GET : $url");
    }

    try {
      final Map<String, String> headers = {};
      final storageToken = Storage.get(StorageKeys.token);

      headers['Content-Type'] = 'application/json';
      if (storageToken != null) {
        headers['Authorization'] = 'Bearer $storageToken';
      }

      final http.Response reponse =
          await http.get(Uri.parse(url), headers: headers);
      // var reponse = await client.get(url);

      return reponse.body;
    } catch (e) {
      if (kDebugMode) {
        print("ERROR DATA   :: $e");
      }
    }
  }
}
