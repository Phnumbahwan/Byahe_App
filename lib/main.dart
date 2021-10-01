import 'package:byahe_app/pages/commuter/locationselection.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/pages/commuter/loginpage.dart';
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
        '/locationselection': (context) => LocationSelection(),
        '/routeselection': (context) => RouteSelection(),
        '/reservevehicle': (context) => ReserveVehicle()
      },
    );
  }
}
