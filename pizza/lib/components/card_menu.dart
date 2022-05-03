import 'package:flutter/material.dart';
import 'package:pizza/models/immagine.dart';

class CardMenu extends StatelessWidget {

  const CardMenu({Key? key}) : super(key: key);

//TODO aggiungere alla card pizza il navigator of context verso la pagina delle pizze preferite
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        shrinkWrap: true,
        physics:NeverScrollableScrollPhysics(),
        itemCount: Immagine.listaImmagini.length,
        itemBuilder: (BuildContext context, index) {
          return SizedBox(
            width: 100,
            height: 200,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                  children: [
                    Expanded(child: Image(image: Immagine.listaImmagini[index])),
                    Container(color: Colors.red,child: Text('ciao')), //TODO mettere a posto il nome della categoia
                  ]),
            ),);
        }
    );
  }
}

/*SizedBox(
      width: 200,
      height: 200,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        child: Column(
            children: [
              Expanded(child: Image(image: AssetImage('assets/pizza.png'))),
              Container(color: Colors.red,child: Text('ciao')),
            ]),
      ),
    );*/
