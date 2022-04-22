import 'package:flutter/material.dart';
enum Interessi{
  mare,
  montagna,
  lago,
  piscina,
  bosco,
  spa
} // come se fosse una lista, mare=0, montagna = 1...

//per utilizzare gli enum ho bisogno di extension method, posso quindi usare la notazione
// interessi.mare per ottenere qualcosa es cambiare colore ecc

 extension InteressiExtension on Interessi {
 IconData get icon {
   switch(this) {
     case Interessi.mare:
        return Icons.waves;
     case Interessi.montagna:
       return Icons.landscape;
     case Interessi.lago:
       return Icons.hiking;
     case Interessi.piscina:
       return Icons.pool;
     case Interessi.bosco:
       return Icons.nature;
     case Interessi.spa:
       return Icons.spa;
    }
  }

 Color get color {
   switch(this) {
     case Interessi.mare:
       return Colors.blue.shade900;
     case Interessi.montagna:
       return Colors.yellow;
     case Interessi.lago:
       return Colors.deepOrangeAccent;
     case Interessi.piscina:
       return Colors.green;
     case Interessi.bosco:
       return Colors.deepPurple;
     case Interessi.spa:
       return Colors.pink;
   }
 }
}