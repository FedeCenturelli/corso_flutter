import 'package:flutter/material.dart';
import 'package:json_prova/routes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: generateRoutes(),
      initialRoute: '/',

      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

