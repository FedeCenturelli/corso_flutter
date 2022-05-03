import 'package:facebook/components/card_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.purple[800],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Choose your profile',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20) ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    CardLogin(
                        id: "60d0fe4f5311236168a109ca",
                        firstName: 'Sara',
                        lastName: "Andersen",
                        imageUrl:
                            'https://randomuser.me/api/portraits/women/58.jpg'),
                    CardLogin(
                        id: "60d0fe4f5311236168a109cb",
                        firstName: 'Edita',
                        lastName: "Vestering",
                        imageUrl:
                            'https://randomuser.me/api/portraits/med/women/89.jpg'),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
