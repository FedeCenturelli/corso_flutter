import 'package:flutter/material.dart';
import 'package:travel_app/models/meta_turistica.dart';
import 'package:travel_app/pages/dettagli.dart';

class CardPlace extends StatelessWidget {
  final MetaTuristica meta;

  const CardPlace(this.meta ,{ Key? key}) : super(key: key);
//posizionale, quindi per richiamare costruttore non occorre scrivere meta:..

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dettagli(meta))),
      child: SizedBox(
        height: 180,
        width: 150,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(meta.imageUrl),
                        fit: BoxFit.cover,
                      )
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(meta.city,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.pin_drop,
                        color: Colors.blueAccent, size: 10),
                    Text(meta.country,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                            fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
