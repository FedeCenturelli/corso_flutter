import 'package:facebook/api/api_comment.dart';
import 'package:facebook/components/data_from_api_comment.dart';
import 'package:facebook/components/post_card.dart';
import 'package:facebook/models/post.dart';
import 'package:flutter/material.dart';


class DettagliPost extends StatefulWidget {
  final Post post;

  const DettagliPost({required this.post, Key? key}) : super(key: key);

  @override
  State<DettagliPost> createState() => _DettagliPostState();
}

class _DettagliPostState extends State<DettagliPost> {
  late TextEditingController _textEditingController;
  String? _message;
  late UniqueKey _key;

  @override
  void initState() {
    _key = UniqueKey();
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        body: ListView(
          shrinkWrap: true,
          children: [
            PostCard(post: widget.post, showCommentButton: false),
            if (widget.post.id != null)
              DataFromApiComment(idPost: widget.post.id!)
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              var popResult = await showModalBottomSheet(
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
                          const Padding(
                            padding: EdgeInsets.all(8.0),
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
                                child: const Text('Annulla'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _message = null;
                                  _textEditingController.clear();
                                },
                                ),
                            TextButton(
                              child: const Text('Pubblica'),
                              onPressed: () async {
                                if(_message == null|| _message!.isEmpty) {
                                  Navigator.of(context).pop();
                                }
                                await ApiComment.addCommentManually(widget.post.id!, _message!);
                                _message = null;
                                _textEditingController.clear();
                                Navigator.of(context).pop(true);
                              })
                          ]),
                        ],),);
                  });
              if(popResult == true) {
                setState(() {
                  _key = UniqueKey();
                });
              }
            }),
      ),
    );
  }
}
