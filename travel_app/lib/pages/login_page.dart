import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _controllerUsername = TextEditingController();
  final _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Travel App',
                        style: TextStyle(
                            color: Colors.blueAccent, fontSize: 30)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: _controllerUsername,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.blue),
                          labelText: 'Username',
                          hintText: 'nome',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.blue,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2,
                              )),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'inserisci un nome';
                          }
                          if(value != 'fede') {
                            return 'username non valido';
                          }
                          return null;
                        }),
                  ),


                  const SizedBox(height: 20,), //spazio tra i form

                  //PASSWORD FORM
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _controllerPassword,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.blue),
                        labelText: 'Password',
                        hintText: 'password',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1
                            )
                        ),
                      ),

                      obscuringCharacter: '*',
                      obscureText: true,
                      autocorrect: false,

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'inserisci una password';
                          }
                          if(value != 'fede') {
                            return 'password non valida';
                          }
                          return null;
                        }
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.blueAccent)
                      ),
                         onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          Navigator.of(context).popAndPushNamed('/');
                        }
                      }
                    ),
                  ),
                ],
              ),
            )));
  }
}

