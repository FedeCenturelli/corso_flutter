import 'dart:convert';

import 'package:facebook/models/comment.dart';
import 'package:facebook/models/comment_response.dart';
import 'package:facebook/models/user.dart';
import 'package:http/http.dart' as http;

class ApiComment {
  static String get baseUrl => 'https://dummyapi.io/data/v1/';

//funzione per ottenere la lista dei commenti
  static Future<CommentResponse> getCommentList() async {
    //di tipo http.response
    final response = await http.get(
        Uri.parse('$baseUrl/post'),
        headers: {'app-id': '626fc967e000f62c19f05f23'}
    );

    print(response.body);

    if (response.statusCode == 200) {
      return CommentResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception('Errore nel ricevere i commenti: ${response.body}');
  }

  //funzione per ottenere commenti per post
  static Future<Comment> getCommentByPost(String id,
      {int page = 0, int limit = 20}) async {
    final response = await http.get(
        Uri.parse('$baseUrl/post/$id/comment?page=$page&limit=$limit'),
        headers: {'app-id': '626fc967e000f62c19f05f23'}
    );

    print(response.body);

    if (response.statusCode == 200) {
      return Comment.fromJson(jsonDecode(response.body));
    }
    throw Exception(
        'Errore nel ricevere i commenti tramite post: ${response.body}');
  }

  //funzione per ottenere i commenti per utente
  static Future<Comment> getCommentByUser(String id,
      {int page = 0, int limit = 20}) async {
    final response = await http.get(
        Uri.parse('$baseUrl/user/$id/comment?page=$page&limit=$limit'),
        headers: {'app-id': '626fc967e000f62c19f05f23'}
    );

    print(response.body);

    if (response.statusCode == 200) {
      return Comment.fromJson(jsonDecode(response.body));
    }
    throw Exception('Errore nel ricevere i commenti per utente: ${response.body}');
  }

}