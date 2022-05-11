import 'package:facebook/api/api_post.dart';
import 'package:facebook/models/post.dart';
import 'package:facebook/models/user.dart';
import 'package:facebook/pages/dettagli_post.dart';
import 'package:facebook/pages/profilo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

//classe per costruire un post

class PostCard extends StatefulWidget {
  final Post post;
  final bool showCommentButton;

  PostCard({required this.post, this.showCommentButton = true, Key? key})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String? _idUtente;
  bool _isFavourite = false;
  late List<String> _favouriteList;
  late SharedPreferences _sp;
  late int _numLikes;
  late bool _postDeleted;

  void initFavourite() async {
    final sp = await SharedPreferences.getInstance();

    //creo la lista dei preferiti dell'utente loggato
    final favouriteList = sp.getStringList('like${_idUtente}') ?? [];
    setState(() {
      _isFavourite = favouriteList.contains(widget.post.id);
      _favouriteList = favouriteList;
      _sp = sp;
    });
  }

  //se l'id del post è presente nella lista dei preferiti lo rimuove se non è presente lo aggiunge
  void isInFavourite() async {
    setState(() {
      if (_favouriteList.contains(widget.post.id)) {
        _favouriteList.remove(widget.post.id);
      } else {
        _favouriteList.add(widget.post.id!);
      }
    });
    await _sp.setStringList('like${_idUtente}', _favouriteList);
    _isFavourite ? _numLikes-- : _numLikes++;

    await ApiPost.modifyPost(Post(
        id: widget.post.id,
        likes: _numLikes,
        owner: const User(firstName: 'Sara', lastName: 'x')));

    setState(() {
      _isFavourite = !_isFavourite;
    });
  }

  Future<void> _initIdUtente() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _idUtente = sp.getString('id');
    });
    if (_idUtente == null) {
      throw Exception('Utente non loggato');
    }
  }

  @override
  void initState() {
    super.initState();
    _initIdUtente();
    _numLikes = widget.post.likes ?? 0;
    initFavourite();
    _postDeleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_postDeleted,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profilo(id: widget.post.owner.id!),
                  ),
                );
              },
              // riga che contiene foto profilo, nome e data, icona per la modifica post
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.post.owner.picture ?? ''),
                    minRadius: 30,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.post.owner.firstName,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  DateFormat('d/M/y H:m').format(DateTime.parse(
                                      widget.post.publishDate ?? '')),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.grey)),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            // l'utente loggato può eliminare solo i post di cui è l'autore
                            if (widget.post.owner.id == _idUtente)
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    late bool result;
                                    if (widget.post.id != null) {
                                      result = await ApiPost.deletePost(
                                          widget.post.id!);
                                    }
                                    setState(() {
                                      _postDeleted = true;
                                    });
                                  }),

                            //TODO implementare la modifica di un post
                            IconButton(
                                icon: const Icon(Icons.more_vert),
                                onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //descrizione del post
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(widget.post.text.toString()),
            ),

                //se i tag di un post sono != null ritorna un cip per ogni tag
            if (widget.post.tags != null)
              Wrap(
                spacing: 8.0,
                children: widget.post.tags!.map((tag) {
                  //uso map perchè ha un tipo di ritorno
                  return Chip(
                      label: Text(tag), backgroundColor: Colors.purple[100]);
                }).toList(),
              ),

            //immagine del post
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image(
                image: NetworkImage(widget.post.image ?? ''),
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),

            //bottone dei like e commenti
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Row(children: [
                          IconButton(
                            onPressed: isInFavourite,
                            icon: Icon(_isFavourite
                                ? Icons.favorite_outlined
                                : Icons.favorite_outline),
                            color: Colors.purple[800],
                          ),
                          Text('${_numLikes} Like'),
                        ]),
                      ],
                    ),
                    if (widget.showCommentButton == true)
                      TextButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  DettagliPost(post: widget.post)),
                        ),
                        child: const Text('Commenti', style: const TextStyle(color: Colors.black),),
                        style: TextButton.styleFrom(
                          side: BorderSide(
                            color: Colors.purple.shade800,
                            width: 2,
                          ),
                        ),
                      ),
                  ]),
            )
          ]),
        ),
      ),
    );
  }
}
