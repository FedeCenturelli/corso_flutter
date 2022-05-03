import 'package:facebook/api/api_post.dart';
import 'package:facebook/components/post_card.dart';
import 'package:facebook/models/post.dart';
import 'package:facebook/pages/menu_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
      body: ListView(
        children: [
          PostCard(post: Post()),
          //PostCard(),
          //PostCard(),
      ]),
    );
  }
}
