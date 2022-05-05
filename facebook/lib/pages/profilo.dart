import 'package:facebook/api/api_user.dart';
import 'package:facebook/components/data_from_api_post.dart';
import 'package:facebook/components/user_info_panel.dart';
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
        title: Text('Profilo'),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, AsyncSnapshot<User> snapshot) {
          if(! snapshot.hasData)
            return Center(
                child: CircularProgressIndicator()
            );

          var user = snapshot.data!; //creo una variabile user con i dati dellosnapshot, assumi che i deti non sono sicuramente nulli
          return Column(
           // shrinkWrap: true,
              children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                  radius: 84,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.network(user.picture ?? '', height: 160, fit: BoxFit.fill,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  child: Text('${user.firstName} ${user.lastName}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30))),
            ),

            Expanded(
              child: ListView(
                children : [
                  UserInfoPanel(user: user),
                  DataFromApiPost(idUserPerPost: user.id)
              ]),
            ),
          ]);
        }
      ),
    );
  }
}

/**/
