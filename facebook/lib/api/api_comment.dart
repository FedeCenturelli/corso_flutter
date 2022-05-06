import 'dart:convert';

import 'package:facebook/models/comment.dart';
import 'package:facebook/models/comment_response.dart';
import 'package:facebook/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiComment {
  static String get baseUrl => 'https://dummyapi.io/data/v1/';

//funzione per ottenere la lista dei commenti
  static Future<CommentResponse> getCommentList() async {
    //di tipo http.response
    final response = await http.get(
        Uri.parse('$baseUrl/post'),
        headers: {'app-id': '626fc967e000f62c19f05f23'}
    );

    if (response.statusCode == 200) {
      return CommentResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception('Errore nel ricevere i commenti: ${response.body}');
  }

  //funzione per ottenere commenti per post
  static Future<CommentResponse> getCommentByPost(String id,
      {int page = 0, int limit = 20}) async {
    final response = await http.get(
        Uri.parse('$baseUrl/post/$id/comment?page=$page&limit=$limit'),
        headers: {'app-id': '626fc967e000f62c19f05f23'}
    );

    if (response.statusCode == 200) {
      return CommentResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception(
        'Errore nel ricevere i commenti tramite post: ${response.body}');
  }

  //funzione per ottenere i commenti per utente
  static Future<CommentResponse> getCommentByUser(String id,
      {int page = 0, int limit = 20}) async {
    final response = await http.get(
        Uri.parse('$baseUrl/user/$id/comment?page=$page&limit=$limit'),
        headers: {'app-id': '626fc967e000f62c19f05f23'}
    );

    if (response.statusCode == 200) {
      return CommentResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception('Errore nel ricevere i commenti per utente: ${response.body}');
  }


  //funzione per aggiungere un commento
  static Future<Comment> addComment(Comment comment) async {
    Map<String, dynamic> _jsonComment = comment.toJson(); //trasformo il commento in json
    _jsonComment.removeWhere((key, value) => value == null);

    //se sono qui significa che il commento non è nullo
    final http.Response response = await http.post(
      Uri.parse('$baseUrl/comment/create'),
      headers: {
        'app-id': '626fc967e000f62c19f05f23',
        'Content-Type' : 'application/json'
      },
      body: jsonEncode({_jsonComment})
    );
    if(response.statusCode == 200) {
      return Comment.fromJson(jsonDecode(response.body));
    }
    throw Exception('Commento non inserito: ${response.body}');
  }


//funzione per eliminare un commento
  static Future<bool> deleteComment(String id) async {
    //se sono qui significa che il commento non è nullo
    final http.Response response = await http.delete(
      Uri.parse('$baseUrl/comment/$id'),
      headers: {
        'app-id': '626fc967e000f62c19f05f23',
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    throw Exception('Commento non eliminato: ${response.body}');
  }

  static Future<Comment> addCommentManually(String postId, String message) async{
    print('prova');

    SharedPreferences sp = await SharedPreferences.getInstance();
    String? userId = sp.getString('id');

    if(userId == null){
      throw Exception('Impossibile insere un commento, per favore fai il login');
    }

    final http.Response response = await http.post(
        Uri.parse('$baseUrl/comment/create'),
        headers: {
          'app-id': '626fc967e000f62c19f05f23',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'owner': userId,
          'post': postId,
          'message': message
        })
    );

    if(response.statusCode == 200){
      return Comment.fromJson(jsonDecode(response.body));
    }
print(response.statusCode);
    throw Exception('Commento non inserito: ${response.body}');
  }
}

