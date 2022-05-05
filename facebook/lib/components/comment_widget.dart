import 'package:facebook/models/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentWidget extends StatelessWidget {
  final Comment commento;

  const CommentWidget({required this.commento, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0),

      //riga intera del commento
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //immagine di chi ha scritto il commento
          CircleAvatar(
            backgroundImage: NetworkImage(commento.owner.picture ?? ''),
            minRadius: 30,
          ),

          // colonna che contiene un container e una riga finale 
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
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${commento.owner.firstName} ${commento.owner.lastName}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                if (commento.publishDate != null)
                                  Text(DateFormat('d/M/y H:m').format(
                                      DateTime.parse(commento.publishDate!))),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(commento.message),
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
    );
  }
}
