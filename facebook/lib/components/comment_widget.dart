import 'package:facebook/api/api_comment.dart';
import 'package:facebook/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentWidget extends StatefulWidget {
  final Comment commento;

  CommentWidget({required this.commento, Key? key}) : super(key: key);


  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late bool _commentDeleted;
  String? _idUtenteLoggato;

  Future<void> _initIdUtente() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _idUtenteLoggato = sp.getString('id');
    });
    if (_idUtenteLoggato == null) {
      throw Exception('Utente non loggato');
    }
  }

  @override
  void initState() {
    super.initState();
    _initIdUtente();
    _commentDeleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_commentDeleted,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0),

        //riga intera del commento
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //immagine di chi ha scritto il commento
            CircleAvatar(
              backgroundImage: NetworkImage(widget.commento.owner.picture ?? ''),
              minRadius: 30,
            ),

            // colonna contiene un container e una riga finale
            // dentro al container: colonna con proprietario e data in una riga, testo del commento
            // dentro alla riga: lke, reply, more
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius:const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    Column(
                                      children: [
                                        Text(
                                            '${widget.commento.owner.firstName} ${widget.commento.owner.lastName}',
                                            style:
                                            const TextStyle(fontWeight: FontWeight.bold)),
                                        if (widget.commento.publishDate != null)
                                          Text(DateFormat('d/M/y H:m').format(
                                              DateTime.parse(widget.commento.publishDate!))),
                                      ],
                                    ),
                                  IconButton(
                                      onPressed: () async {
                                        if(widget.commento.owner.id != _idUtenteLoggato) {
                                          const snackBar = SnackBar(
                                              content: Text('Non puoi eliminare questo commento, non sei l\'autore'));
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        } else {
                                          if (widget.commento.id != null) {
                                            bool result = await ApiComment.deleteComment(
                                                widget.commento.id!);
                                            setState(() {
                                              _commentDeleted = true;
                                            });
                                          }
                                        }
                                      },
                                      icon: const Icon(Icons.delete),
                                  )
                                ],),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(widget.commento.message),
                            ],
                          ),
                        )),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0, right: 8.0, left: 8.0, top: 4.0),
                        child: Text('Like',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700])),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0, right: 8.0, left: 8.0, top: 4.0),
                        child: Text('Reply',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700])),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0, right: 8.0, left: 8.0, top: 4.0),
                        child: Text('More',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700])),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
