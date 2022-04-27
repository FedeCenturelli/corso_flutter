import 'package:flutter/material.dart';
import 'package:travel_app/components/card_place.dart';
import 'package:travel_app/components/filter_drawer.dart';
import 'package:travel_app/components/search.dart';
import 'package:travel_app/models/meta_turistica.dart';
import 'package:travel_app/components/search.dart';

class RicercaPage extends StatefulWidget {
  //stateful perchè man mano chescrivo si aggiornano risultati
  const RicercaPage({Key? key}) : super(key: key);

  @override
  State<RicercaPage> createState() => _RicercaPageState();
}

class _RicercaPageState extends State<RicercaPage> {
  //variabili da aggiornare ogni volta che i filtri vengono settati
  late int _minRating;
  late int _maxRating;
  String? _parolaDiRicerca;

  late List<MetaTuristica> _risultatiRicerca;

  @override
  void initState() {
    super.initState();
    _risultatiRicerca = MetaTuristica.listaMete;
    _minRating = 1;
    _maxRating = 5;
  }

//funzione con parametri nominali, i parametri sono riempiti con parametri dei filtri settati nel drawer con appica
// quindi le variabili della pagina di ricerca vengono aggiornate con i param del drawer
  void setFilters({int minRating =1, int maxRating = 5}) {
    //prima salvo i filtri
    _minRating = minRating;
    _maxRating = maxRating;


    //poi applico i filtri
    _filtraMete(_parolaDiRicerca ?? ''); //se parola di ricerca è nullo restituisce stringa vuota
  }

  bool _additionalFiltersFor(MetaTuristica meta) {
    return meta.rating >= _minRating && meta.rating <= _maxRating;
  }

  void _filtraMete(String parolaDiRicerca) {
    //parola di ricerca inserita nella ricerca
    _parolaDiRicerca = parolaDiRicerca;

    if (parolaDiRicerca.isEmpty) {
      setState(() {
        _risultatiRicerca =
            MetaTuristica.listaMete.where((meta) => _additionalFiltersFor(meta))
                .toList();
      });
    } else {
      setState(() {
        _risultatiRicerca = MetaTuristica.listaMete.where((meta) {
          return meta.city.toLowerCase().contains(parolaDiRicerca.toLowerCase())
              && _additionalFiltersFor(meta);
        })
            .toList();
      });
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Ricerca', style: TextStyle(color: Colors.grey)),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.grey,
                size: 30,
              )),
        ),
        endDrawerEnableOpenDragGesture: false,
        endDrawer: FilterDrawer(
          selectedRating:
              RangeValues(_minRating.toDouble(), _maxRating.toDouble()),
          setFilters: setFilters,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Search(amIOnHomepage: false, callBack: _filtraMete),
            _risultatiRicerca.length == 0
                ? const Text('Nessun risultato')
                : Expanded(
                    child: ListView.builder(
                        itemCount: _risultatiRicerca.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: CardPlace(_risultatiRicerca[index]),
                          );
                        }),
                  )
          ]),
        ));
  }
}

