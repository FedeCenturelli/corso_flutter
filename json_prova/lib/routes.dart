import 'package:json_prova/models/user.dart';
import 'package:json_prova/pages/home.dart';
import 'package:json_prova/pages/user_info_page.dart';

generateRoutes() {

  return {
    '/' : (context) => Home(),
  '/user_info_page' : (context) => UserInfoPage(),
  };
}