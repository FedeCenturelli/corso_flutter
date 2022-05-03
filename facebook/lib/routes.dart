import 'package:facebook/pages/home.dart';
import 'package:facebook/pages/login.dart';
import 'package:facebook/pages/profilo.dart';

generateRoutes() {
  return {
    '/' : (context) => const Home(),
    '/login' : (context) => const Login(),
    '/profilo' : (context) => const Profilo(),
  };
}