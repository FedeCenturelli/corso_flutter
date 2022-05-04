import 'package:facebook/api/api_user.dart';
import 'package:facebook/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profilo extends StatefulWidget {
  final String? id;

  const Profilo({this.id, Key? key}) : super(key: key);

  @override
  State<Profilo> createState() => _ProfiloState();
}

class _ProfiloState extends State<Profilo> {
  late Future<User> _future;

  @override
  void initState() {
    _future = _fetchUser(widget.id!);
    super.initState();
  }

  Future<User> _fetchUser(String id) async {
    return ApiUser.getDetailsFor(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('profilo'),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          return ListView(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                  radius: 84,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.network('https://randomuser.me/api/portraits/women/58.jpg', height: 160, fit: BoxFit.fill,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  child: Text('nome e cognome')),
            ),
            Card(
                child: Column(

                  children: [
                    Row(
                      children: [
                        Icon(Icons.phone),
                        Text('telefono'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.email),
                        Text('email'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.male),
                        Text('gender'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.place),
                        Text('indirizzo'),
                      ],
                    ),
                  ],
                )
            )
          ]);
        }
      ),
    );
  }
}

/**/
