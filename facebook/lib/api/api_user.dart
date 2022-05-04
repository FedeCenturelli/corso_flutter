import 'dart:convert';

import 'package:facebook/models/user.dart';
import 'package:facebook/models/user_response.dart';
import 'package:http/http.dart' as http;

class ApiUser {
  static String get baseUrl => 'https://dummyapi.io/data/v1/';

  //funzione per ottenere la lista degli utenti
  static Future<UserResponse> getUserList() async {
    //la response ha un body e in questo caso header required per ogni risposta
    final response = await http.get(Uri.parse('$baseUrl/user'),
        headers: {'app-id': '626fc967e000f62c19f05f23'}
    );
    if (response.statusCode == 200) {
      return UserResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception('Errore in ricevere la lista gli utenti: ${response.body}');
  }


//funzione per ottenere le informazioni degli utenti
  static Future<User> getDetailsFor(String id, {int page = 0, int limit = 20}) async {
    final response = await http.get(
        Uri.parse('$baseUrl/user/$id?page=$page&limit=$limit'),
        headers: {'app-id':'626fc967e000f62c19f05f23'}
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    throw Exception('Errore in ricevere gli utenti: ${response.body}');
  }
}
