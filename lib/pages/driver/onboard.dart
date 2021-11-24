import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/commuter/topbarmod.dart';

class Onboard extends StatefulWidget {
  // const Onboard({ Key? key }) : super(key: key);

  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
                    child: Column(children: <Widget>[
      Container(height: 50, child: TopBarMod()),
      Container(
        child: Text(
          'BYAHE',
          style: TextStyle(color: Colors.yellowAccent[700], fontSize: 30),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/undraw_by_my_car_ttge-removebg-preview.png"),
                fit: BoxFit.cover)),
        child: Text('TEST'),
      )
    ])))));
  }
}
