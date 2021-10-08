import 'package:byahe_app/pages/commuter/locationselection.dart';
import 'package:byahe_app/pages/register/registerdriver.dart';
import 'package:byahe_app/pages/register/registerdriverconfirmation.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/pages/login/loginpage.dart';
import 'package:byahe_app/pages/register/registerpage.dart';
import 'package:byahe_app/pages/register/registercommuternickname.dart';
import 'package:byahe_app/pages/register/registercommuter.dart';
import 'package:byahe_app/pages/commuter/routeselection.dart';
import 'package:byahe_app/pages/commuter/reservevehicle.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/loginpage',
      routes: {
        '/loginpage': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/registercommuter': (context) => RegisterCommuter(),
        '/registercommuternickname': (context) => RegisterCommuterNickname(),
        '/registerdriver': (context) => RegisterDriver(),
        '/registerdriverconfirmation': (context) => RegisterDriverConfirmation(),
        '/locationselection': (context) => LocationSelection(),
        '/routeselection': (context) => RouteSelection(),
        '/reservevehicle': (context) => ReserveVehicle()
      },
    );
  }
}
