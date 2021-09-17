import 'package:flutter/material.dart';
import 'package:Byahe_App/pages/loginpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/loginpage',
      routes: {'/loginpage': (context) => LoginPage()},
    );
  }
}
