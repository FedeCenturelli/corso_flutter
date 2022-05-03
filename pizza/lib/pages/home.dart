import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza/components/card_menu.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Discovery',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
        ),
        body: ListView(

          children: [
            Center(
              child: Wrap(
                children: [
                  CardMenu(),
                ]),
            ),
              ],
            )
    );
  }
}
