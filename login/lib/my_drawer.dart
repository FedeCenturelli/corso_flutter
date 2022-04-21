import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[200],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  //padding: new EdgeInsets.only(top: 0.0),
                  icon: const Icon(Icons.close, color: Colors.blueAccent),
                  onPressed: () => Navigator.of(context).pop()),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage('assets/login.jpg'))),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: ListView(
                    children: const [
                      ListTile(
                        leading: Icon(Icons.menu),
                        title: Text('Menù options'),
                      ),
                      ListTile(
                        leading: Icon(Icons.circle),
                        title: Text('Refounds'),
                      ),
                      ListTile(
                        leading: Icon(Icons.money),
                        title: Text('Transaction'),
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Settings'),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
