import 'dart:convert';

import 'package:facebook/models/post.dart';
import 'package:facebook/models/post_response.dart';
import 'package:facebook/models/user.dart';
import 'package:facebook/models/user_response.dart';
import 'package:http/http.dart' as http;

class ApiPost {
  static String get baseUrl => 'https://dummyapi.io/data/v1/';

//funzione per ottenere la lista dei post
  static Future<PostResponse> getPostList({int page = 0, int limit = 20}) async {
    //di tipo http.response
    final response = await http.get(
        Uri.parse('$baseUrl/post?page=$page&limit=$limit'),
        headers: {'app-id': '626fc967e000f62c19f05f23'}
    );


    if (response.statusCode == 200) {
      return PostResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception('Errore nel ricevere i post: ${response.body}');
  }

  //funzione per ottenere post tramite utente
  static Future<PostResponse> getPostByUser(String id, {int page = 0, int limit = 20}) async {
    final response = await http.get(
        Uri.parse('$baseUrl/user/$id/post?page=$page&limit=$limit'),
        headers: {'app-id': '626fc967e000f62c19f05f23'}
    );


    if (response.statusCode == 200) {
      return PostResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception(
        'Errore nel ricevere i post tramite il propriario: ${response.body}');
  }

  //funzione per ottenere post tramite il tag
  static Future<Post> getPostByTag(String id,
      {int page = 0, int limit = 20}) async {
    final response = await http.get(
        Uri.parse('$baseUrl/tag/$id/post?page=$page&limit=$limit'),
        headers: {'app-id': '626fc967e000f62c19f05f23'}
    );

    //print(response.body); //controllo per json

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    }
    throw Exception('Errore nel ricevere i post tramite id: ${response.body}');
  }

  //funzione per ottenere post tramite post id
  static Future<Post> getPostById(String id,
      {int page = 0, int limit = 20}) async {
    final response = await http.get(
        Uri.parse('$baseUrl/post/$id?page=$page&limit=$limit'),
        headers: {'app-id': '626fc967e000f62c19f05f23'}
    );


    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    }
    throw Exception('Errore nel ricevere i post tramite id: ${response.body}');
  }
}