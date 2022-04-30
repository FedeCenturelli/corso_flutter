import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/models/meta_turistica.dart';

class Preferiti extends StatefulWidget {


  const Preferiti({Key? key}) : super(key: key);

  @override
  State<Preferiti> createState() => _PreferitiState();
}

class _PreferitiState extends State<Preferiti> {


  List<MetaTuristica> listaMetePreferite = []; // contine le mete di lista mete che trovano una corrispondenza della città nella lista preferiti
  List<String> preferitiSalvati = []; //preferiti in SharedPreferences

  void initializeSharedPreferences () async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    preferitiSalvati = sp.getStringList('preferiti') ?? [];

    setState(() {
      MetaTuristica.listaMete.forEach((element) {  //scorro tutte le mete se la città di una meta è nei preferiti la inserisco
        if(preferitiSalvati.contains(element.city)) {
          listaMetePreferite.add(element);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.grey,
              size: 50,
            )),
        title: const Text(
          'Preferiti',
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
      body: ListView.builder(
        itemCount: listaMetePreferite.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: SizedBox(
                height: 100,
                width:100,
                child: Image.network(listaMetePreferite[index].imageUrl),
              ),
              title: Text(listaMetePreferite[index].city),
              subtitle: Text(listaMetePreferite[index].country),
            ),
          );
        }
      ),
    );
  }
}
