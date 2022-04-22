import 'package:flutter/material.dart';
import 'package:travel_app/components/card_place.dart';
import 'package:travel_app/components/titolo.dart';
import 'package:travel_app/models/meta_turistica.dart';

class PopularPlaces extends StatelessWidget {
  const PopularPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Titolo(titolo: 'Popular Places'),
          SizedBox(
            height: 200,
            child:ListView.builder(
                scrollDirection: Axis.horizontal,

                itemCount: (MetaTuristica.listaMete.length),
                itemBuilder: (context,index) {

                  return  CardPlace(
                     MetaTuristica.listaMete[index]);
                }
            ),

          ),
        ],
      ),
    );
  }
}
