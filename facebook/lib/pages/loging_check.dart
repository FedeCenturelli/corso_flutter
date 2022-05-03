import 'package:facebook/pages/home.dart';
import 'package:facebook/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCheck extends StatefulWidget {
  const LoginCheck({Key? key}) : super(key: key);

  @override
  State<LoginCheck> createState() => _LoginCheckState();
}

class _LoginCheckState extends State<LoginCheck> {
  String? id;

  initializeSharedPreferences() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    id = sp.getString('id');
  }

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  //se id è nullo utete non loggato quindi mostra login, se no mostra home eprchè utente è loggato
  @override
  Widget build(BuildContext context) {
    return id == null? Login() : Home();
  }
}
