import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/pages/home.dart';
import 'package:travel_app/pages/login_page.dart';

class Reinderizzamento extends StatefulWidget {
  const Reinderizzamento({Key? key}) : super(key: key);

  @override
  _ReinderizzamentoState createState() => _ReinderizzamentoState();
}

class _ReinderizzamentoState extends State<Reinderizzamento> {

  bool loggato = false;

  void initializeSharedPreferences() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState((){
      loggato = sp.getBool('loggato') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
}

  @override
  Widget build(BuildContext context) {
    return loggato ? (Home()) : (LoginPage());
  }
}
