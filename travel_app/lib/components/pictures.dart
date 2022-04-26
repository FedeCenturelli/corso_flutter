import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pictures extends StatelessWidget {
  final String immagine;
  const Pictures(this.immagine, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)
        ),
        child: Container(
          width: 100,
          height: 100,
          decoration:  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(immagine),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.all(Radius.circular(25))),
        ),
      ),
    );
  }
}
