import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:travel_app/components/category_card.dart';
import 'package:travel_app/components/titolo.dart';
import 'package:travel_app/models/interessi.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Titolo(titolo: 'Category'),
        SizedBox(
          height: 115,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Row(
                children: <Widget>[Text('')] +
                    Interessi.values
                        .map((interesse) => CategoryCard(
                      icona: interesse.icon,
                      testo: interesse.name,
                      colore: interesse.color,
                    ))
                        .toList(),

                // values metodo degli enum
                //map è un ciclo che cicla qualcosa, interesse è il valore in cui il ciclo si trova (chiamarlo con l'elemnte singolare della mappa)
                // ritorna un widget del tipo che mi serve, quindi un testo
                //ritorna un iterable, su cui posso usare un ciclo, il to list serve a trasformare l'iterable in lista che posso usare in una riga
              ),
            ],
          ),
        ),
      ],
    );
  }
}
