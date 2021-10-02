import 'package:byahe_app/pages/commuter/locationselection.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/pages/login/loginpage.dart';
import 'package:byahe_app/pages/register/registerpage.dart';
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
        '/locationselection': (context) => LocationSelection(),
        '/routeselection': (context) => RouteSelection(),
        '/reservevehicle': (context) => ReserveVehicle()
      },
    );
  }
}
