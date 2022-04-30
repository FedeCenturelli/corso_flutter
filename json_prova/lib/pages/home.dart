import 'package:flutter/material.dart';
import 'package:json_prova/api/api_user.dart';
import 'package:json_prova/models/user.dart';
import 'package:json_prova/models/user_response.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<User> usersVisualizzati;
  late bool moreUsers;
  late int skipUser;
  late Future<List<User>> _future;

  void initState() {
    super.initState();
    usersVisualizzati = [];
    moreUsers = false; //ci sono altri user che non sono stati ancora visulaizzati
    skipUser= 0;
    _future = _fetchUser();
  }

  Future <List<User>> _fetchUser() async {
    final UserResponse usersResult = await ApiUser.getUserFromInternet(skip: skipUser);
    setState(() {
      skipUser=  skipUser + usersResult.limit;
      moreUsers = (usersResult.total - skipUser > 0);
      usersVisualizzati = usersVisualizzati + usersResult.users;
    });
    return usersVisualizzati;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Users'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            usersVisualizzati = [];
            moreUsers= false;
            skipUser = 0;
            _future = _fetchUser();
          });
          return Future.value();
        },

        child: FutureBuilder(
          future: _future,
          builder: (context, snapShot) {
            if(snapShot.hasData && snapShot.data is List<User>) {
              final user = (snapShot.data as List<User>); //utenti

              return ListView.builder(
                  itemCount: usersVisualizzati.length + (moreUsers ? 1 : 0),
                  itemBuilder: (contex, index) {
                    if (index == user.length) { //indice uguale alla lunghezza della lista di tutti gli utenti
                      _future = _fetchUser();
                      return const Center(child:
                       CircularProgressIndicator(),);
                    }
                    return Card(
                      child: ListTile(
                        onTap:() => Navigator.of(context).pushNamed('/user_info_page'),
                        leading: Icon(Icons.person),
                        title: Text(user[index].firstName),
                        subtitle: Text('Age: ${user[index].age.toString()}'),
                      ),
                    );
                  }
              );
            }
            if(snapShot.hasError) {
             return Center(child: Text(snapShot.error.toString()));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
