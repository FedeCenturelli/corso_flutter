import 'package:flutter/material.dart';
import 'package:nuovo_progetto/my_drawer.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
        ),
        drawer: MyDrawer(),
        body: Center(
          child: Container(
            color: Colors.grey[200],
            child: Column(
              children: [
                const SizedBox(
                    width: 250,
                    height: 250,
                    child: Image(image: AssetImage('assets/login.jpg'))),
                const Text('Welcome Back',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    )),
                const Text('Login to your existing account',
                    style: TextStyle(color: Colors.grey)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                      child: TextFormField(

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey, width:2),
                              borderRadius: BorderRadius.circular(50.0)
                          ),
                          icon: const Icon(Icons.person, color: Colors.blueAccent,),
                          labelText: 'email',
                          labelStyle: const TextStyle(color: Colors.blueAccent),
                          hintText: 'username@mail.it',
                          hintStyle: TextStyle(color: Colors.grey),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blueAccent, width:2),
                            borderRadius: BorderRadius.circular(50.0)
                          ),

                        )
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
