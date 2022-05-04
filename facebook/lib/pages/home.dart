import 'package:facebook/api/api_post.dart';
import 'package:facebook/components/post_card.dart';
import 'package:facebook/models/post.dart';
import 'package:facebook/models/post_response.dart';
import 'package:facebook/pages/menu_drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Post> _listaPostVisualizzati; //lista dei post
  late int _skipPost;
  late bool hasMorePost;
  late int _page;
  late Future<List<Post>> _future;



  Future<List<Post>> _fetchPosts() async {
    final PostResponse result = await ApiPost.getPostList(page: _page); //get post list ritorna un oggetto di tipo future
    setState(() {
    _skipPost = _skipPost + result.limit;
    hasMorePost = (result.total - _skipPost) > 0;
    _page = _page +1;
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

// ApiPost.getPostByTag('60d21b4667d0d8992e610c85'); //controllo per json


    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.purple[800],
        centerTitle: true,
        title: Text('Social App'),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data is List<Post>) {
           List<Post> posts = snapshot.data as List<Post>;
           return ListView.builder(
             itemCount: posts.length+(hasMorePost? 1:0),
             itemBuilder: (context, index) {
               if(posts.length == index) {
                 _future= _fetchPosts();
                 return Center(
                   child: CircularProgressIndicator()
                 );
               }
               return PostCard(post: posts[index]);
             }
           );
          }
          if(snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(
              child: CircularProgressIndicator());
        }
        ),
    );
  }
}
