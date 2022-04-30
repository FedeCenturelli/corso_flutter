import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_prova/models/user_response.dart';

class ApiUser {
  static Future<UserResponse> getUserFromInternet({int skip=0}) async {

    final response = await http.get(Uri.parse("https://dummyjson.com/users?skip$skip"));

    if(response.statusCode == 200) {
      return UserResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception('Errore ${response.statusCode}');
    }
  }
