import 'package:byahe_app/data/data.dart';
import 'package:byahe_app/pages/driver/setup-alley.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/topbarmod.dart';
import 'package:byahe_app/widgets/driver/navigationalcontainer.dart';

class SetupCheck extends StatefulWidget {
  // const SetupCheck({ Key? key }) : super(key: key);

  @override
  _SetupCheckState createState() => _SetupCheckState();
}

class _SetupCheckState extends State<SetupCheck> {
  String pageName = 'Set-up';
  // ignore: non_constant_identifier_names
  int total_drivers_area = 55;
  // ignore: non_constant_identifier_names
  int total_drivers_route = 10;
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
          this.pageName.toUpperCase(),
          style: TextStyle(color: Colors.yellowAccent[700], fontSize: 30),
        ),
      ),
      NavigationalContainer(this.pageName),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                width: 180,
                height: 70,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SetupAlley()));
                    },
                    style: ElevatedButton.styleFrom(
                        onPrimary: Colors.yellow[700], primary: Colors.white),
                    child: Text("Alley",
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                width: 180,
                height: 70,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SetupCheck()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow[700],
                    ),
                    child: Text("Check drivers",
                        style: TextStyle(fontWeight: FontWeight.bold))))
          ],
        ),
      ),
      Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.centerRight,
          child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SetupCheck()));
              },
              child: Image.asset(
                'assets/reload.png',
                width: 40,
              ))),
      Container(
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(30),
                child: Column(children: <Widget>[
                  Text('TOTAL DRIVERS IN YOUR AREA',
                      style: TextStyle(
                          color: Colors.yellow[700],
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  Text(
                    this.total_drivers_area.toString(),
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.yellow[700],
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  )
                ])),
            Container(
              padding: EdgeInsets.all(30),
              child: Column(children: <Widget>[
                Text('TOTAL DRIVERS IN THE SAME ROUTE',
                    style: TextStyle(
                        color: Colors.yellow[700],
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                Text(
                  this.total_drivers_route.toString(),
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.yellow[700],
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                )
              ]),
            )
          ],
        ),
      )
    ])))));
  }
}
