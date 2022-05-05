import 'package:facebook/components/data_from_api_comment.dart';
import 'package:facebook/components/post_card.dart';
import 'package:facebook/models/post.dart';
import 'package:flutter/material.dart';

class DettagliPost extends StatelessWidget {
  final Post post;

  const DettagliPost({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            PostCard(post: post,showCommentButton: false),
            if(post.id != null)
            DataFromApiComment(idPost: post.id!)
          ],
        ),
      ),
    );
  }
}
