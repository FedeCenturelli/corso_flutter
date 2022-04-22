import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/components/titolo.dart';
import 'package:travel_app/models/meta_turistica.dart';

class Dettagli extends StatelessWidget {
  final MetaTuristica meta;

  const Dettagli(this.meta, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
padding: EdgeInsets.all(0),
      children: [
        Stack(
          //no stack figlio diretto di stack
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            //IMMAGINE
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(meta.imageUrl),
                ),
              ),
            ),

            //ICONA FRECCIA INDIETRO
            Positioned(
                top: 50,
                left: 25,
                child: (Container(
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.chevron_left, size: 50),
                ))),

            //ICONA SALVATO
            Positioned(
                top: 50,
                right: 25,
                child: (Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.bookmark, size: 30),
                ))),


            //CONTAINER DAL BASSO
            Positioned(
              bottom: 0, //alla fine dello stack
              left:0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25))),
              ),
            ),

            Positioned(
              bottom: 0,
              child: Card (
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  width: 300,
                  height: 120,
                  decoration:  BoxDecoration(

                    shape: BoxShape.circle,
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Titolo(titolo: meta.city),
                          Row(
                            children: [
                              const Icon(Icons.pin_drop,
                                  color: Colors.blueAccent, size: 16),
                              Text(meta.country,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                      fontSize: 18)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                              children: const [
                                Icon(Icons.train),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal:8.0),
                                  child: Text('2 days'),
                                ),
                          ]
                        ),
                          Row(
                              children: [
                                Icon(Icons.star),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:8.0),
                                  child: Text(meta.rating.toString()),
                                ),
                              ]),
                          Row(
                              children: const [
                                Icon(Icons.schedule_outlined),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal:8.0),
                                  child: Text('12 H'),
                                ),
                              ]),
                        ]
                      ),
                    ],
                  )
                ),
              ),
            ),

          ],
        ),


        Container(
          height: 60,
          color: Colors.white,
        ),Container(
          height: 50,
          color: Colors.white,
        ),Container(
          height: 50,
          color: Colors.white,
        ),Container(
          height: 50,
          color: Colors.white,
        ),Container(
          height: 50,
          color: Colors.white,
        ),Container(
          height: 50,
          color: Colors.white,
        ),Container(
          height: 50,
          color: Colors.white,
        ),Container(
          height: 50,
          color: Colors.white,
        ),Container(
          height: 50,
          color: Colors.white,
        ),Container(
          height: 50,
          color: Colors.white,
        ),
      ],
    )
    );
  }
}
