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
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://randomuser.me/api/portraits/women/58.jpg'),
                    minRadius: 30,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text( post.owner?.firstName ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('2020-05-24T14:53:17.598Z',style: TextStyle(fontSize: 15, color: Colors.grey))
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('ice caves in the wild landscape photo of ice near ...'),
              ),
              Wrap(
                spacing: 8.0,
                children:  [
                    Chip(
                      label: Text('tag'),
                      backgroundColor: Colors.purple[100],
                    ),
                    Chip(
                      label: Text('tag'),
                      backgroundColor: Colors.purple[100],
                    ),
                    Chip(
                      label: Text('tag'),
                      backgroundColor: Colors.purple[100],
                    ),
                    Chip(
                        label: Text('tag'),
                      backgroundColor: Colors.purple[100],
                    ),
                ]
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image(image: NetworkImage('https://img.dummyapi.io/photo-1564694202779-bc908c327862.jpg'), width: double.infinity,fit: BoxFit.fitWidth,),
              ),
            ]
        ),
      ),
    );
  }
}
