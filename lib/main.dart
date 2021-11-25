import 'package:byahe_app/pages/commuter/locationselection.dart';
import 'package:byahe_app/pages/register/registerdriver.dart';
import 'package:byahe_app/pages/register/registerdriverconfirmation.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/pages/login/loginpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({ Key? key }) : super(key: key);
  static bool alley = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      // initialRoute: '/loginpage',
      // routes: {
      //   '/loginpage': (context) => LoginPage(),
      //   '/register': (context) => RegisterPage(),
      //   '/registercommuter': (context) => RegisterCommuter(),
      //   '/registercommuternickname': (context) => RegisterCommuterNickname(),
      //   '/registerdriver': (context) => RegisterDriver(),
      //   '/registerdriverconfirmation': (context) =>
      //       RegisterDriverConfirmation(),
      //   '/locationselection': (context) => LocationSelection(),
      //   '/routeselection': (context) => RouteSelection(),
      //   '/reservevehicle': (context) => ReserveVehicle()
      // },
    );
  }
}
