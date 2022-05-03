import 'package:flutter/material.dart';
import 'package:pizza/models/pizza.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PizzePreferite extends StatefulWidget {



  const PizzePreferite({Key? key}) : super(key: key);
  @override
  State<PizzePreferite> createState() => _PizzePreferiteState();
}

class _PizzePreferiteState extends State<PizzePreferite> {

  late SharedPreferences sp;
  late List<String> preferiti = []; //variabile in cui salvo preferiti

  void initializeSharedPreferences() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      preferiti = sp.getStringList('preferiti') ?? [];
    });
  }

  /*void addToFavourite(String id) async {
    //print('id $id');
    SharedPreferences sp = await SharedPreferences.getInstance();

    setState(() {
      preferiti.add(id);
    });
    sp.setStringList('preferiti', preferiti);

    /*var x = (id == '5' ) ? 'ciao' : 'test';
    print(x);*/
  }*/

  void isInFavourite(String id) async {
    //controllare se elemento presente nella lista, se non c'è lo aggiunge, se c'è lo rimuove
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      if (preferiti.contains(
          id)) { //se nella lista di preferiti trovo un id significa che il cuore è pieno
        preferiti.remove(id);
      } else {
        preferiti.add(id);
      }
    });
    sp.setStringList('preferiti', preferiti);
  }


  @override
  void initState() {
    initializeSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pizze'),
      ),
      body: ListView.builder(
        itemCount: Pizza.listaPizze.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(Pizza.listaPizze[index].nome),
            trailing: IconButton(
              icon: preferiti.contains(Pizza.listaPizze[index].id) ? Icon(
                  Icons.favorite) : const Icon(Icons.favorite_border),
              onPressed: () => isInFavourite(Pizza.listaPizze[index].id),
            ),
          );
        },
      ),
    );
  }
}
