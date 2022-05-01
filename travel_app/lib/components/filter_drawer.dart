import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/models/meta_turistica.dart';

class FilterDrawer extends StatefulWidget {
  //variabili attuali per memorizzare i valori dei filtri
  final RangeValues selectedRating;
  final String? selectedCountry;
  final bool available;

  //funzione per passare al drawer il filtro settato
  final Function(
      {int minRating,
      int maxRating,
      String? country,
      bool available}) setFilters;

  const FilterDrawer(
      {required this.selectedRating,
      required this.setFilters,
      this.selectedCountry,
      this.available = false,
      Key? key})
      : super(key: key);

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  late RangeValues _selectedRating;
  String? _selectedCountry;
  late bool? _available;
  late List<String> _countryList; //lista stati delle mete

  @override
  void initState() {
    super.initState();
    _selectedRating = widget
        .selectedRating; //widget. per riferirsi al valore del widget filter drawer
    _selectedCountry = widget.selectedCountry;
    _available = widget.available;

    //popolo la lista gli stati con tutti gli stati delle mete turistiche senza ripetizioni con toSet
    _countryList =
        MetaTuristica.listaMete.map((meta) => meta.country).toSet().toList();

    _countryList.sort(); //in ordine alfabetico
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Filtri',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 20)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Rating',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 15)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('1'),
                  RangeSlider(
                      min: 1,
                      max: 5,
                      values: _selectedRating,
                      onChanged: (RangeValues value) {
                        setState(() {
                          _selectedRating = value;
                        });
                      },
                      divisions: 4,
                      labels: RangeLabels(
                        _selectedRating.start.toString().substring(0, 1),
                        _selectedRating.end.toString().substring(0, 1),
                      )),
                  const Text('5'),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormField(builder: (context) {
                  return InputDecorator(
                      decoration: const InputDecoration(
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        labelText: 'Country',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 20),
                        border: OutlineInputBorder(),
                      ),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              value: _selectedCountry,
                              items: <DropdownMenuItem<String>>[
                                    const DropdownMenuItem(
                                      child: Text('nessuno stato selezionato'),
                                      value: null,
                                    )
                                  ] +
                                  _countryList
                                      .map((country) => DropdownMenuItem<String>(
                                            child: Text(country),
                                            value: country,
                                          ))
                                      .toList(),
                              onChanged: (metaSelezionata) {
                                setState(() {
                                  _selectedCountry = metaSelezionata;
                                });
                              })));
                }),
              ),
              SizedBox(
                height: 30,
              ),
              SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Available',
                      style: TextStyle(fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 15),),
                  ),
                  value: _available ?? false,
                  onChanged: (toggle){
                    setState(() {
                      _available = toggle;
                    });
                  }
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        _available = null;
                        _selectedCountry = null;
                        _selectedRating = const RangeValues(1, 5);
                      });
                    },
                    child: const Text('Reset', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 20))
                ),
                TextButton(
                    onPressed: () {
                      widget.setFilters(
                        minRating: _selectedRating.start.toInt(),
                        maxRating: _selectedRating.end.toInt(),
                      );
                    },
                    child: Text('Applica', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 20)
                    )
                ),
              ],
            ),
          ),
        ],
      ),

    ));
  }
}
