import 'package:flutter/material.dart';
import 'package:json_prova/models/user.dart';

class UserInfoPage extends StatelessWidget {

  UserInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User info'),
      ),
      body: ListView(
       children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Card(
             elevation: 5,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 children:  [
                   CircleAvatar(
                     maxRadius: 45,
                   ),
                   Padding(
                     padding: EdgeInsets.all(8.0),
                     child: Text('nome', style: TextStyle(fontSize: 20),),
                   ),
                 ],
               ),
             )
       ),
         )
       ])
    );
  }
}
