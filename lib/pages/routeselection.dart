import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/topbarmod.dart';
import 'package:byahe_app/widgets/percentindicator.dart';
import 'package:flutter/rendering.dart';

class RouteSelection extends StatefulWidget {
  // const RouteSelection({ Key? key }) : super(key: key);

  @override
  _RouteSelectionState createState() => _RouteSelectionState();
}

class _RouteSelectionState extends State<RouteSelection> {
  var locationRoute = [
    {
      'route': 'ROUTE - RD',
      'status': 2,
      'active': false,
      'vehicle_status': 'ALLEY',
      'time_to_leave': 13,
      'seats_availability': 2,
      'vehicle_plate_number': 'KMJS 404',
      'route_destination':
          'Cugman-Gusa-Lapasan-Gaisano-Capistrano st-Divisoria-Cogon-Ketkai'
    },
    {
      'route': 'ROUTE - RC',
      'status': 5,
      'active': false,
      'vehicle_status': 'ALLEY',
      'time_to_leave': 13,
      'seats_availability': 2,
      'vehicle_plate_number': 'KMJS 404',
      'route_destination':
          'Cugman-Gusa-Lapasan-Gaisano-Capistrano st-Divisoria-Cogon-Ketkai'
    },
    {
      'route': 'ROUTE - BUGO',
      'status': 3,
      'active': false,
      'vehicle_status': 'ALLEY',
      'time_to_leave': 13,
      'seats_availability': 2,
      'vehicle_plate_number': 'KMJS 404',
      'route_destination':
          'Cugman-Gusa-Lapasan-Gaisano-Capistrano st-Divisoria-Cogon-Ketkai'
    },
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
                        .map(
                          (route) => Container(
                              child: ExpansionPanelList(
                                  expansionCallback:
                                      (int index, bool isExpanded) {
                                    setState(() {
                                      route['active'] = !route['active'];
                                    });
                                  },
                                  children: <ExpansionPanel>[
                                ExpansionPanel(
                                    backgroundColor: Colors.yellow[700],
                                    headerBuilder: (BuildContext context,
                                        bool isExpanded) {
                                      return Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              "• " + route['route'],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                              child: PercentIndicator(
                                                  route['status'])),
                                        ],
                                      );
                                    },
                                    isExpanded: route['active'],
                                    canTapOnHeader: true,
                                    body: Container(
                                        child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Image.asset(
                                              'assets/undraw_fast_car_p4cu-removebg-preview.png',
                                              height: 100),
                                        ),
                                        Container(
                                            padding: EdgeInsets.all(10),
                                            child: Column(children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                      child: Row(
                                                    children: <Widget>[
                                                      Text("Status : ",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(
                                                        "${route['vehicle_status']}",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.green,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  )),
                                                  Container(
                                                      child: Row(children: <
                                                          Widget>[
                                                    Text(
                                                      "Vehicle Plate Number: ",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "${route['vehicle_plate_number']}",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ]))
                                                ],
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                        child: Row(children: <
                                                            Widget>[
                                                      Text(
                                                        "Time to leave : ",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "${route['time_to_leave']} mins/s left",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors
                                                                .orange[700],
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ]))
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                        child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          "Seats availability : ",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          "${route['seats_availability']}/10",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.green,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ))
                                                  ]),
                                              Row(children: <Widget>[
                                                Container(
                                                    child: Wrap(
                                                        direction:
                                                            Axis.vertical,
                                                        children: <Widget>[
                                                      Text(
                                                        "ROUTE : ",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "${route['route_destination']}",
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ]))
                                              ])
                                            ])),
                                        Container(
                                          child: Image.asset(
                                              'assets/Screenshot_6.png'),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors
                                                              .yellow[700],
                                                          side: BorderSide(
                                                            color: Colors.white,
                                                          )),
                                                  child: Text("QUEUE NOW!")),
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          onPrimary: Colors
                                                              .yellow[700],
                                                          primary:
                                                              Colors.white),
                                                  child: Text("RESERVE NOW!"))
                                            ],
                                          ),
                                        )
                                      ],
                                    ))),
                              ])),
                        )
                        .toList()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
