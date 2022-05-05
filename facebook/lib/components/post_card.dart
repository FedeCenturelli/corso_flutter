import 'package:facebook/models/post.dart';
import 'package:facebook/pages/dettagli_post.dart';
import 'package:facebook/pages/profilo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final bool showCommentButton;
  PostCard({required this.post, this.showCommentButton = true, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profilo(id: post.owner.id!),
                ),
              );
            },
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post.owner.picture ?? ''),
                  minRadius: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.owner.firstName,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),

                      Text(DateFormat('d/M/y H:m').format(DateTime.parse(post.publishDate ?? '')), style: TextStyle(fontSize: 15, color: Colors.grey)),
                    ],),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(post.text.toString()),
          ),

          //se i tag di un post sono != null ritorna un cip per ogni tag
          if (post.tags != null)
            Wrap(
              spacing: 8.0,
              children: post.tags!.map((tag) {
                //uso map perchè ha un tipo di ritorno
                return Chip(
                    label: Text(tag), backgroundColor: Colors.purple[100]);
              }).toList(),
            ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Image(
              image: NetworkImage(post.image ?? ''),
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          final snackBar = SnackBar(
                            content: Text('Liked!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                        child: Row(
                          children: [
                            Icon(Icons.favorite_outlined, color: Colors.purple[800],),
                          Text('${post.likes.toString()} Like'),
                          ]),
                      ),
                    ],
                  ),
                  if(showCommentButton == true)
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => DettagliPost(post: post)),
                    ),
                    child: Text('Commenti', style: TextStyle(color: Colors.black),),
                    style: TextButton.styleFrom(
                      side: BorderSide(color: Colors.purple.shade800, width: 2,),
                  ),
                ),
                ]),
          )
        ]),
      ),
    );
  }
}
