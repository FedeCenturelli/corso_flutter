import 'package:flutter/material.dart';


class Search extends StatelessWidget {
  final Function(String)? callBack;
  //string è il tipo di paramentro di cui ha bisogno la funzione
  final bool amIOnHomepage;

  const Search({this.amIOnHomepage = false, this.callBack, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onTap: amIOnHomepage ? () {
                FocusScope.of(context).unfocus();
                Navigator.of(context).pushNamed('/ricerca');
              } : null,
               onChanged: callBack,
                readOnly: amIOnHomepage,
                autofocus: !amIOnHomepage,
                decoration: const  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.search),
                )),
          ),
        ),
        Container(
          width: 60,
          height: 60,

          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child:
          IconButton(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: Icon(Icons.filter_list, color: Colors.blueAccent),
          )
        ),
      ],
    );
  }
}
