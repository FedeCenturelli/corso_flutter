import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:travel_app/models/meta_turistica.dart';

class BottonePrefetiti extends StatefulWidget {
  final MetaTuristica meta;

  const BottonePrefetiti(this.meta, {Key? key}) : super(key: key);

  @override
  _BottonePrefetitiState createState() => _BottonePrefetitiState();
}

class _BottonePrefetitiState extends State<BottonePrefetiti> {
  late bool favourite = false; //la meta è preferita o no
  late List<String> preferiti = [];

  void initializeSharedpreferences() async {
    StreamingSharedPreferences sp = await StreamingSharedPreferences.instance;
    preferiti = sp.getStringList('preferiti', defaultValue: []).getValue();

    setState(() {
      favourite = preferiti.contains(widget.meta.city);
    });
  }

  void addToPreferiti() async {
    StreamingSharedPreferences sp = await StreamingSharedPreferences.instance;
    preferiti = sp.getStringList('preferiti', defaultValue: []).getValue();

    preferiti.add(widget.meta.city);
  }

  void removeToPreferiti() async {
    StreamingSharedPreferences sp = await StreamingSharedPreferences.instance;
    preferiti = sp.getStringList('preferiti', defaultValue: []).getValue();

    preferiti.remove(widget.meta.city);

  }

  @override
  void initState() {
    super.initState();
    initializeSharedpreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white54, borderRadius: BorderRadius.circular(10)),
        child: IconButton(
            padding: EdgeInsets.zero,
            icon: favourite == false
                ? Icon(Icons.bookmark_border_outlined, size: 30)
                : Icon(Icons.bookmark, size: 30),
            onPressed: () {
              favourite == false ? addToPreferiti() : removeToPreferiti();

              //se è  falso significa che posso aggiungerlo ai preferiti e quindi andra a vero
              setState(() {
                favourite = !favourite;
              });
            }));
  }
}
