import 'dart:convert';

import 'package:facebook/models/post.dart';
import 'package:facebook/models/post_response.dart';
import 'package:http/http.dart' as http;

class ApiPost {
  static String get baseUrl => 'https://dummyapi.io/data/v1';

//funzione per ottenere la lista dei post
  static Future<PostResponse> getPostList(
      {int page = 0, int limit = 20}) async {
    //di tipo http.response
    final response = await http.get(
        Uri.parse('$baseUrl/post?page=$page&limit=$limit'),
        headers: {'app-id': '626fc967e000f62c19f05f23'});

    if (response.statusCode == 200) {
      return PostResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception('Errore nel ricevere i post: ${response.body}');
  }

  //funzione per ottenere post tramite utente
  static Future<PostResponse> getPostByUser(String id,
      {int page = 0, int limit = 20}) async {
    final response = await http.get(
        Uri.parse('$baseUrl/user/$id/post?page=$page&limit=$limit'),
        headers: {'app-id': '626fc967e000f62c19f05f23'});

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
        headers: {'app-id': '626fc967e000f62c19f05f23'});

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
        headers: {'app-id': '626fc967e000f62c19f05f23'});

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    }
    throw Exception('Errore nel ricevere i post tramite id: ${response.body}');
  }

  //funzione per aggiungere un post
  static Future<Post> addPost(Post post, String userId) async {
    Map<String, dynamic> _jsonPost = post.toJson(); //trasformo il post in json
    _jsonPost.removeWhere((key, value) => value == null);
    _jsonPost['owner'] = userId;

    //se sono qui significa che il post non è nullo
    final http.Response response = await http.post(
        Uri.parse('$baseUrl/post/create'),
        headers: {
          'app-id': '626fc967e000f62c19f05f23',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(_jsonPost));
    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    }
    throw Exception('Aggiunta del commento fallita: ${response.body}');
  }

//funzione per eliminare un post
  static Future<bool> deletePost(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('$baseUrl/post/$id'),
      headers: {
        'app-id': '626fc967e000f62c19f05f23',
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    throw Exception('Post non eliminato: ${response.body}');
  }

  //funzione per modificare un post
  static Future<Post> modifyPost(Post post) async {
    Map<String, dynamic> _jsonPost = post.toJson(); //trasformo il post in json
    _jsonPost.removeWhere((key, value) => value == null);

    //se sono qui significa che il post non è nullo
    final http.Response response = await http.put(
        Uri.parse('$baseUrl/post/${post.id}'),
        headers: {
          'app-id': '626fc967e000f62c19f05f23',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(_jsonPost));
    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    }
    throw Exception('Modifica non riuscita: ${response.body}');
  }
}
