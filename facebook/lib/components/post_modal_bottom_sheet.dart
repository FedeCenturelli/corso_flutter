import 'package:facebook/api/api_post.dart';
import 'package:facebook/models/post.dart';
import 'package:facebook/models/user.dart';
import 'package:flutter/material.dart';

class PostModalBottomSheet extends StatefulWidget {
  final Post? post;
  final String userId;

  const PostModalBottomSheet(this.userId,{this.post,Key? key}) : super(key: key);

  @override
  _PostModalBottomSheetState createState() => _PostModalBottomSheetState();
}

class _PostModalBottomSheetState extends State<PostModalBottomSheet> {
  late TextEditingController _controllerText;
  late TextEditingController _controllerTags;

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      _controllerText = TextEditingController(text: widget.post!.text);
      final String? tags = widget.post!.tags?.join(',');
      _controllerTags = TextEditingController(text: tags);
    } else {
      _controllerText = TextEditingController();
      _controllerTags = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: EdgeInsets.only(
            top: 8.0,
            left: 8.0,
            right: 8.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
              children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Aggiungi una descrizione',
              ),
              controller: _controllerText,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'tags',
              ),
              controller: _controllerTags,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                 child: const Text('Annulla'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  onPressed: () async {
                    if(_controllerText.text.isNotEmpty) {
                      final _newPost = Post(
                        id: widget.post?.id,
                        text: _controllerText.text,
                        tags: _controllerTags.text.split(', '),
                        image: "https://img.dummyapi.io/photo-1564694202779-bc908c327862.jpg",
                        owner: const User(firstName: 'Fede' , lastName: 'Centurelli')
                      );
                      if(widget.post != null ) {
                        await ApiPost.modifyPost(_newPost);
                      } else {
                        await ApiPost.addPost(_newPost, widget.userId);
                      }
                      Navigator.of(context).pop(true);
                    }
                    else {
                      throw Exception('Inserire un testo nel post');
                    }
                  },
                    child: widget.post != null ? const Text('Aggiorna') : const Text('Pubblica')
                )
              ]
            )
          ])
      ),
    );
  }
}
