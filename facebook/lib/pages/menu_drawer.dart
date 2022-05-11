import 'package:facebook/pages/profilo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        const SizedBox(
          height: 150,
          child:  DrawerHeader(
            child: Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Text(
                'Menu',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/drawer.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Profilo'),
          onTap: () async {
            SharedPreferences sp = await SharedPreferences.getInstance();
            var _loggedId = sp.getString('id');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profilo(id: _loggedId)));
          },
        ),
        const ListTile(
          leading: Icon(Icons.settings),
          title: Text('Impostazioni'),
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () => Navigator.of(context).popAndPushNamed('/login'),
        )
      ],
    ));
  }
}
