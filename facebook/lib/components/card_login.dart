import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardLogin extends StatefulWidget {
  final String id;
  final String firstName;
  final String lastName;
  final String imageUrl;

  const CardLogin(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.imageUrl,
      Key? key})
      : super(key: key);

  @override
  State<CardLogin> createState() => _CardLoginState();
}

class _CardLoginState extends State<CardLogin> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 230,
      child: GestureDetector(
        onTap: () async {
          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setString('id', widget.id);
          Navigator.of(context).pushNamed('/');
        },
        child: Card(
          elevation: 7,
          color: Colors.white38,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white54, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.imageUrl),
                radius: 50,
              ),
              Text(
                '${widget.firstName} ${widget.lastName}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
