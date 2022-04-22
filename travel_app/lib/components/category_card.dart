import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {

  final IconData icona;
  final String testo;
  final Color colore;
  const CategoryCard({required this.icona, required this.testo, required this.colore,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colore,
                  borderRadius: BorderRadius.circular(10),

                ),
                width: 50,
                height: 50,
                child: Icon(icona),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(testo, style: const TextStyle(
                    color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
