import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/topbarmod.dart';
import 'package:byahe_app/widgets/commuter/percentindicator.dart';
import 'package:byahe_app/pages/commuter/map.dart';
import 'package:flutter/rendering.dart';
import 'package:byahe_app/data/data.dart';

class RouteSelection extends StatefulWidget {
  // const RouteSelection({ Key? key }) : super(key: key);

  @override
  _RouteSelectionState createState() => _RouteSelectionState();
}

class _RouteSelectionState extends State<RouteSelection> {
  void resetQueued() {
    setState(() {
      locationRoute.map((route) {
        return route['queue'] = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
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
                        .map((route) => InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Map(route)));
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.yellow[700],
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "• " + route['route'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                          child: PercentIndicator(
                                              route['status'])),
                                    ]),
                                    Container(
                                      child: Icon(Icons.place,
                                          color: Colors.white),
                                    )
                                  ],
                                ))))
                        .toList()),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
