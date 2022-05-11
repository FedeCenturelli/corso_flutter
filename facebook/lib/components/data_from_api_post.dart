import 'package:facebook/api/api_post.dart';
import 'package:facebook/components/post_card.dart';
import 'package:facebook/models/post.dart';
import 'package:facebook/models/post_response.dart';
import 'package:flutter/material.dart';

//widget che recupera i dati dalle api
class DataFromApiPost extends StatefulWidget {
  final String? idUserPerPost; // opzionale per filtrare i post per utenti
  const DataFromApiPost({this.idUserPerPost, Key? key}) : super(key: key);

  @override
  State<DataFromApiPost> createState() => _DataFromApiPostState();
}

class _DataFromApiPostState extends State<DataFromApiPost> {
  late List<Post> _listaPostVisualizzati; //lista dei post
  late int _skipPost;
  late bool hasMorePost;
  late int _page;
  late Future<List<Post>> _future;

  Future<List<Post>> _fetchPosts() async {
    late PostResponse result;

    //se l'id dell'utente è nullo allora chiamo la funzione che recupera i dati dei post, altrimenti quella che recupera i dati dei post per utente
    if (widget.idUserPerPost == null) {
      result = await ApiPost.getPostList(
          page: _page); //get post list ritorna un oggetto di tipo future
    } else {
      result = await ApiPost.getPostByUser(widget.idUserPerPost!, page: _page);
    }
    setState(() {
      _skipPost = _skipPost + result.limit;
      hasMorePost = (result.total - _skipPost) > 0;
      _page = _page + 1;
      _listaPostVisualizzati = _listaPostVisualizzati + result.data;
    });
    return _listaPostVisualizzati;
  }

  @override
  void initState() {
    _listaPostVisualizzati = [];
    _skipPost = 0;
    hasMorePost = false;
    _page = 0;
    _future = _fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data is List<Post>) {
            List<Post> posts = snapshot.data as List<Post>;
            return ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: posts.length + (hasMorePost ? 1 : 0),
                itemBuilder: (context, index) {
                  if (posts.length == index) {
                    _future = _fetchPosts();
                    return const Center(child: CircularProgressIndicator());
                  }
                  return PostCard(post: posts[index]);
                });
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
