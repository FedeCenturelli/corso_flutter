import 'package:flutter/material.dart';
import 'package:travel_app/components/search.dart';

class RicercaPage extends StatefulWidget {
  //stateful perchè man mano chescrivo si aggiornano risultati
  const RicercaPage({Key? key}) : super(key: key);

  @override
  State<RicercaPage> createState() => _RicercaPageState();
}

class _RicercaPageState extends State<RicercaPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ricerca')
      ),
      body:Padding(
        padding:const  EdgeInsets.all(8.0),
        child: Column(
          children: [
            Search(

            )
          ]
        ),
      )
    );
  }
}
