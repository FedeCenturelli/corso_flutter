import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:travel_app/models/meta_turistica.dart';

class Preferiti extends StatelessWidget {
  final StreamingSharedPreferences sp;

  const Preferiti(this.sp,{Key? key}) : super(key: key);


  List<MetaTuristica> getMetePreferite(List<String> _preferences) {
    List<MetaTuristica> metePreferite = [];
    for(var meta in MetaTuristica.listaMete) {
      if(_preferences.contains(meta.city)) {
        metePreferite.add(meta);
      }
    }
    return metePreferite;
  }

  void initializeSharedPreferences () async {
    StreamingSharedPreferences sp = await StreamingSharedPreferences.instance;
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
