import 'package:facebook/api/api_comment.dart';
import 'package:facebook/components/data_from_api_comment.dart';
import 'package:facebook/components/post_card.dart';
import 'package:facebook/models/comment.dart';
import 'package:facebook/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DettagliPost extends StatefulWidget {
  final Post post;

  const DettagliPost({required this.post, Key? key}) : super(key: key);

  @override
  State<DettagliPost> createState() => _DettagliPostState();
}

class _DettagliPostState extends State<DettagliPost> {
  late TextEditingController _textEditingController;
  String? _message;


  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            PostCard(post: widget.post, showCommentButton: false),
            if (widget.post.id != null)
              DataFromApiComment(idPost: widget.post.id!)
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    //cosa andare inserire all'interno della bottomoSheet
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 8.0,
                          left: 8.0,
                          right: 8.0,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('inserisci il commento'),
                          ),
                          TextField(
                            controller: _textEditingController,
                            maxLines: 5,
                            onChanged: (value) {
                              _message = _textEditingController.text;
                            },
                          ),
                          Row(children: [
                            TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Annulla')),
                            TextButton(
                              child: Text('Pubblica'),
                              onPressed: () async {
                                if(_message == null|| _message!.isEmpty) {
                                  Navigator.of(context).pop();
                                }

                                final response= await ApiComment.addCommentManually(widget.post.id!, _message!);

                                print(response.id);
                                Navigator.of(context).pop();
                              }
                            )
                          ]),
                        ],
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
