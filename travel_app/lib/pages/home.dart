import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/components/card_place.dart';
import 'package:travel_app/components/category.dart';
import 'package:travel_app/components/category_card.dart';
import 'package:travel_app/components/popular_places.dart';
import 'package:travel_app/components/recommended.dart';
import 'package:travel_app/components/search.dart';
import 'package:travel_app/models/interessi.dart';
import 'package:travel_app/models/meta_turistica.dart';
import 'package:travel_app/pages/login_page.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //toglie ombra appbar
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          //la row ha le dimension esatte dei figli
          children: const [
            Icon(Icons.pin_drop, color: Colors.blue),
            Text('Italia', style: TextStyle(color: Colors.blue)),
          ],
        ),
        actions: const [
          CircleAvatar(backgroundColor: Colors.yellow, child: Text('FC'))
        ],
      ),
      drawer: Drawer(
        
        child: Column(
         children: [
           DrawerHeader(child: Row(
             children: [
               CircleAvatar(backgroundColor: Colors.yellow,
                   child: Text('FC')),
               Padding(
                 padding: const EdgeInsets.only(left: 8.0),
                 child: Text('Federica Centurelli'),
               ),
             ],
           )),
           ListTile(leading: Icon(Icons.home), title: Text('Home'),
               onTap: () => Navigator.of(context).pushNamed('/home')),
           ListTile(leading: Icon(Icons.person), title: Text('Account'),
               onTap: () => Navigator.of(context).pushNamed('/profile')),
           ListTile(leading: Icon(Icons.favorite), title: Text('Preferiti'),
               onTap: () => Navigator.of(context).pushNamed('/favourites')),
           ListTile(leading: Icon(Icons.search), title: Text('Global search'),
               onTap: () => Navigator.of(context).pushNamed('/mete')),
           ListTile(leading: Icon(Icons.person), title: Text('Logout'),
               onTap: () async {
             SharedPreferences sp = await SharedPreferences.getInstance();
             sp.setBool('loggato', false);
             Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
           }
           ),
    ])
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Category(),
                  Search(amIOnHomepage: true),
                  PopularPlaces(),
                  Recommended(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
