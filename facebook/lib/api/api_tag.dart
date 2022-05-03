import 'dart:convert';
import 'package:facebook/models/tag_response.dart';
import 'package:facebook/models/user_response.dart';
import 'package:http/http.dart' as http;

class ApiTag {
  static String get baseUrl => 'https://dummyapi.io/data/v1/';

  //funzione per ottenere la lista dei tag
  static Future<TagResponse> getUserList() async {
    //la response ha un body e in questo caso header required per ogni risposta
    final response = await http.get(Uri.parse('$baseUrl/tag'),
        headers: {'app-id': '626fc967e000f62c19f05f23'}
    );

    if (response.statusCode == 200) {
      return TagResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception('Errore in ricevere la lista dei tag: ${response.body}');
  }
}