import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/topbarmod.dart';
import 'package:byahe_app/widgets/percentindicator.dart';

class RouteSelection extends StatefulWidget {
  // const RouteSelection({ Key? key }) : super(key: key);

  @override
  _RouteSelectionState createState() => _RouteSelectionState();
}

class _RouteSelectionState extends State<RouteSelection> {
  var locationRoute = [
    {'route': 'ROUTE - RD', 'status': 2},
    {'route': 'ROUTE - RC', 'status': 5},
    {'route': 'ROUTE - BUGO', 'status': 3}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              TopBarMod(),
              Container(
                  padding: EdgeInsets.all(15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Trip to Gusa",
                        style:
                            TextStyle(fontSize: 20, color: Colors.yellow[700])),
                  )),
              Container(
                child: Column(
                  children: locationRoute
                      .map((route) => Container(
                          padding: EdgeInsets.all(20),
                          color: Colors.yellow[700],
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                child: Text("• " + route['route'],
                                    style: TextStyle(color: Colors.white)),
                              )),
                              Expanded(
                                  child: PercentIndicator(route['status'])),
                              Expanded(
                                child: Image.asset(
                                  'assets/arrow-down-sign-to-navigate.png',
                                  height: 30,
                                  width: 30,
                                ),
                              )
                            ],
                          )))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
