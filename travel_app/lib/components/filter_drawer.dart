import 'package:flutter/material.dart';

class FilterDrawer extends StatefulWidget {
  //variabile per memorizzare i parametri dello slider
  final RangeValues selectedRating;

  //funzione per passare al drawer il filtro settato
  final Function({int minRating, int maxRating}) setFilters;

  const FilterDrawer({required this.selectedRating, required this.setFilters, Key? key})
      : super(key: key);

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  late RangeValues selectedRating;

  @override
  void initState() {
    super.initState();
    selectedRating = widget.selectedRating;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Filtri',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 18)),
          ),
          RangeSlider(
              min: 1,
              max: 5,
              values: selectedRating,
              onChanged: (RangeValues value) {
                setState(() {
                  selectedRating = value;
                });
              },
              divisions: 4,
              labels: RangeLabels(
                selectedRating.start.toString().substring(0, 1),
                selectedRating.end.toString().substring(0, 1),
              )),
          Row(
            children: [
              TextButton(
                onPressed: (){
                  widget.setFilters(
                    minRating: selectedRating.start.toInt(),
                    maxRating: selectedRating.end.toInt(),
                  );
                },
                child: Text('Applica')
              )
            ],
          )
        ],
      ),
    ));
  }
}
