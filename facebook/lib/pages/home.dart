import 'package:facebook/api/api_post.dart';
import 'package:facebook/components/data_from_api_post.dart';
import 'package:facebook/components/post_card.dart';
import 'package:facebook/models/post.dart';
import 'package:facebook/models/post_response.dart';
import 'package:facebook/pages/menu_drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.purple[800],
        centerTitle: true,
        title: Text('Social App'),
      ),
      body: DataFromApiPost(), //widget per costruire post sulla home
    );
  }
}
