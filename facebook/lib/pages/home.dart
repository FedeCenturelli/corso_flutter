import 'package:facebook/components/data_from_api_post.dart';
import 'package:facebook/components/post_modal_bottom_sheet.dart';
import 'package:facebook/pages/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String? _idUtente;
  UniqueKey key= UniqueKey();

  Future<void> _initIdUtente() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _idUtente = sp.getString('id');
    });
    if (_idUtente == null) {
      throw Exception('Utente non loggato');
    }
  }

  @override
  void initState() {
    super.initState();
    _initIdUtente();
  }

  void setKey() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if(_idUtente != null) {
            final change = await showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => PostModalBottomSheet(_idUtente!));
            if (change == true) {
              setKey();
            }
          }
        },
        label: const Text('New Post'),
        backgroundColor: Colors.purple[800],
      ),
      drawer: const MenuDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.purple[800],
        centerTitle: true,
        title: const Text('Social App'),
      ),
      body: const DataFromApiPost(), //widget per costruire post sulla home
    );
  }
}
