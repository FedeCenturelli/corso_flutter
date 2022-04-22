import 'package:flutter/material.dart';

class Titolo extends StatelessWidget {
  final String titolo;
  const Titolo({required this.titolo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(titolo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          )),
    );
  }
}
