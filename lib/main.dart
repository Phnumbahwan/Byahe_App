import 'package:byahe_app/pages/locationselection.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/pages/loginpage.dart';

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
        '/locationselection': (context) => LocationSelection()
      },
    );
  }
}
