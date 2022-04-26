import 'package:flutter/material.dart';
import 'package:travel_app/pages/account.dart';
import 'package:travel_app/pages/global_search.dart';
import 'package:travel_app/pages/home.dart';
import 'package:travel_app/pages/login_page.dart';
import 'package:travel_app/pages/preferiti.dart';
import 'package:travel_app/pages/ricerca_page.dart';

generateRoutes() {
  return {
    '/': (context) => Home(),
    '/profile': (context) => Account(),
    '/details': (context) => const Center(child: Text('Dettagli')),
    '/favourites': (context) => const Center(child: Preferiti()),
    '/mete': (context) => const Center(child: GlobalSearch()),
    '/login': (contex) => const Center(child: LoginPage()),
    '/ricerca': (contex) => const Center(child: RicercaPage())
  };
}