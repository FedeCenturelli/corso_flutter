import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {

  final IconData icona;
  final String testo;
  final Color colore;

  const CategoryCard({required this.icona, required this.testo, required this.colore,Key? key}) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {

  final bool attivo = false;

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
                  color: widget.colore,
                  borderRadius: BorderRadius.circular(10),

                ),
                width: 50,
                height: 50,
                child: Icon(widget.icona, color: Colors.black54),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(widget.testo, style: const TextStyle(
                    color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
