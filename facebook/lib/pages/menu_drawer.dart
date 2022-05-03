import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        SizedBox(
          height: 150,
          child:  DrawerHeader(
                child: Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: Text('Menu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
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
          onTap: () => Navigator.of(context).popAndPushNamed('/profilo'),
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () => Navigator.of(context).popAndPushNamed('/login'),
        )
      ],
    ));
  }
}
