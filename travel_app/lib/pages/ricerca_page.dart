import 'package:flutter/material.dart';
import 'package:travel_app/components/card_place.dart';
import 'package:travel_app/components/filter_drawer.dart';
import 'package:travel_app/components/search.dart';
import 'package:travel_app/models/meta_turistica.dart';


class RicercaPage extends StatefulWidget {
  //stateful perchè man mano chescrivo si aggiornano risultati
  const RicercaPage({Key? key}) : super(key: key);

  @override
  State<RicercaPage> createState() => _RicercaPageState();
}

class _RicercaPageState extends State<RicercaPage> {

  //variabili da aggiornare ogni volta che i filtri vengono settati nel drawer
  late int _minRating;
  late int _maxRating;
  String? _country;
  bool? _available;
  String? _parolaDiRicerca;

  late List<MetaTuristica> _risultatiRicerca;

  @override
  void initState() {
    super.initState();
    _risultatiRicerca = MetaTuristica.listaMete;
    _minRating = 1;
    _maxRating = 5;
    _risultatiRicerca = MetaTuristica.listaMete;
  }

// funzione con param nominali che aggiorna le variabili di stato con valori settati nel drawer
  void setFilters({int minRating =1, int maxRating = 5, String? country, bool? available}) {
    //prima salvo i filtri
    _minRating = minRating;
    _maxRating = maxRating;
    _country= country;
    _available = available;


    //applico i filtri del drawer anche nella pagina di ricerca
    _filtraMete(_parolaDiRicerca ?? ''); //se parola di ricerca è nullo restituisce stringa vuota
  }

  bool _additionalFiltersFor(MetaTuristica meta) {
    return meta.rating >= _minRating && meta.rating <= _maxRating
        && (_country == null || meta.country == _country)
        && (_available == null || _available == false || meta.available == _available);
  }

  void _filtraMete(String parolaDiRicerca) {

    _parolaDiRicerca = parolaDiRicerca;

    // se la parola di ricerca è una stringa vuota restituisci tutte le mete che soddisfano i filtri
    if (parolaDiRicerca.isEmpty) {
      setState(() {
        _risultatiRicerca =
            MetaTuristica.listaMete.where((meta) => _additionalFiltersFor(meta))
                .toList();
      });

      //estrai mete la cui città corrisponde alla parola di ricerca e che soddisfano i filtri
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

