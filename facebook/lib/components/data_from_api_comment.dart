import 'package:facebook/api/api_comment.dart';
import 'package:facebook/components/comment_widget.dart';
import 'package:facebook/models/comment.dart';
import 'package:facebook/models/comment_response.dart';
import 'package:flutter/material.dart';

class DataFromApiComment extends StatefulWidget {
  final String idPost;

  const DataFromApiComment({required this.idPost,Key? key}) : super(key: key);

  @override
  _DataFromApiCommentState createState() => _DataFromApiCommentState();
}

class _DataFromApiCommentState extends State<DataFromApiComment> {
  late List<Comment> _listaCommentiVisualizzati;
  late int _skipComment;
  late bool hasMoreComment;
  late int _page;
  late Future<List<Comment>> _future;

  Future<List<Comment>> _fetchComments() async {
     CommentResponse result = await ApiComment.getCommentByPost(widget.idPost);

     setState(() {
       _listaCommentiVisualizzati = _listaCommentiVisualizzati + result.data;
       _skipComment = _skipComment +result.limit;
       hasMoreComment = (result.total - _skipComment) >0;
       _page = _page+1;
     });
     return _listaCommentiVisualizzati;
  }

  @override
  void initState() {
    _listaCommentiVisualizzati = [];
    _skipComment = 0;
    hasMoreComment = false;
    _page = 0;
    _future = _fetchComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, AsyncSnapshot<List<Comment>>snapshot) {
        if(snapshot.hasData) {
          List<Comment> comments = snapshot.data ?? [];
          if(comments.isNotEmpty) {
            return ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: comments.length + (hasMoreComment ? 1 : 0),
                itemBuilder: (context, index) {
                  if (comments.length == index) {
                    _future = _fetchComments();
                    return Center(
                        child: CircularProgressIndicator()
                    );
                  }
                  return CommentWidget(commento: comments[index]);
                }
            );
          } else {
            return Text("non ci sono commenti da visualizzare");
          }
        }
        if(snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }
}
