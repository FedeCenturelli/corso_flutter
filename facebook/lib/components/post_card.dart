import 'package:facebook/models/post.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Post post;

  PostCard({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
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
                    Text(post.publishDate ?? '',
                        style: TextStyle(fontSize: 15, color: Colors.grey))
                  ],
                ),
              ),
            ],
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
                  Icon(
                    Icons.favorite,
                    color: Colors.purple[800],
                  ),
                  Text(post.likes.toString()),
                ],
              ),

                  Text('commenti'),
            ]),
          )
        ]),
      ),
    );
  }
}
