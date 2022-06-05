import 'dart:async';
import 'package:byahe_app/data/data.dart';
import 'package:byahe_app/main.dart';
import 'package:byahe_app/pages/driver/setup-check.dart';
import 'package:byahe_app/widgets/drawer/drawerheader.dart';
import 'package:byahe_app/widgets/drawer/drawerlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/topbarmod.dart';
import 'package:byahe_app/widgets/driver/navigationalcontainer.dart';
import 'package:byahe_app/pages/login_auth.dart';
import 'package:provider/src/provider.dart';
import 'package:location/location.dart' as locate;
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

class SetupAlley extends StatefulWidget {
  // const SetupAlley({ Key? key }) : super(key: key);

  @override
  _SetupAlleyState createState() => _SetupAlleyState();
}

class _SetupAlleyState extends State<SetupAlley> {
  String pageName = 'Set-up';
  //String groupname = 'MODA JEEP ORG';
  //String myPlatenumber = 'KMJS 000';
  Stream<QuerySnapshot> alley;
  String status;
  String driverPath;
  String driverPlate;
  bool broadcast;
  var vehicleStatus;
  var alley_state;
  var alleyList = [];
  //DateTime date = Timestamp.now().toDate();
  //String formattedDate =
  //  DateFormat('yyyy-MM-dd – kk:mm').format(Timestamp.now().toDate());
  final locate.Location location = locate.Location();
  StreamSubscription<locate.LocationData> _locationSubscription;

  bool clicked_back = false;
  bool clicked_forward = false;

  @override
  void initState() {
    super.initState();
    requestForPerms();
    fetchPath();
    fetchAlleyList();
    fetchPlateNum();
    fetchVehicleStatus();
    fetchBroadcast();
    location.changeSettings(
        interval: 300, accuracy: locate.LocationAccuracy.high);
    //location.enableBackgroundMode(enable: true);
  }

  fetchPath() async {
    dynamic result = await context.read<Authenticate>().getDriverRoutePath();
    if (result == null) {
      print('Unable to retrieve driver path (setup-alley.dart)');
    } else {
      if (mounted) {
        setState(() {
          driverPath = result;
        });
      }
    }
  }

  fetchBroadcast() async {
    dynamic result = await context.read<Authenticate>().getBroadcastStatus();
    if (result == null) {
      print('Unable to retreive broadcast status (setup-alley.dart)');
    } else {
      if (mounted) {
        setState(() {
          broadcast = result;
        });
      }
    }
  }

  fetchPlateNum() async {
    dynamic result = await context.read<Authenticate>().getPlate();
    if (result == null) {
      print('Unable to retrieve driver plate number (setup-alley.dart)');
    } else {
      if (mounted) {
        setState(() {
          driverPlate = result;
        });
      }
    }
  }

  fetchVehicleStatus() async {
    dynamic result = await context.read<Authenticate>().retrieveVehicleStatus();
    if (result == null) {
      print('Unable to retreive vehicle_status (setup-alley.dart)');
    } else {
      if (mounted) {
        setState(() {
          vehicleStatus = result;
        });
      }
    }
  }

  fetchAlleyList() async {
    dynamic result = await context.read<Authenticate>().getAlleyList();
    if (result == null) {
      print('Unable to retrieve driver alley list (setup-alley.dart');
    } else {
      if (mounted) {
        setState(() {
          alleyList = result;
        });
      }
    }
  }

  alleyFunction() {
    if (MyApp.alley == false) {
      return Text('CONFIRM ALLEY',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.yellow[700]));
    } else {
      return Text('STOP ALLEY', style: TextStyle(color: Colors.white));
    }
  }

  Future<void> getLiveLocation() async {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError.toString());
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((locate.LocationData currentLocation) async {
      await FirebaseFirestore.instance.collection('users').doc(useruid).set({
        'latitude': currentLocation.latitude,
        'longitude': currentLocation.longitude,
        'driver_heading': currentLocation.heading,
        'circle_accuracy': currentLocation.accuracy,
      }, SetOptions(merge: true));
    });
  }

  stopLiveLocation() async {
    await _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  requestForPerms() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('Request granted');
    } else if (status.isDenied) {
      requestForPerms();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  alleyType() {
    if (MyApp.clicked_forward == true && MyApp.clicked_back == false) {
      return StreamBuilder(
          stream: alley = FirebaseFirestore.instance
              .collection('users')
              .where('user_type', isEqualTo: "Driver")
              .where('route_path', isEqualTo: driverPath)
              .where('vehicle_status', isEqualTo: "ALLEY-FROM-ORIGIN")
              .orderBy('alley_time', descending: false)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Center(child: Text('Failed to Retreive Info')));
            }
            if (snapshot.hasData == false) {
              return Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Center(child: CircularProgressIndicator()));
            }
            return Column(
                children: snapshot.data.docs
                    .map((jeep) => Container(
                        decoration: BoxDecoration(
                            color: driverPlate == jeep['vehicle_plate_number']
                                ? Colors.yellowAccent[700]
                                : Colors.yellow[700],
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.grey,
                                  offset: Offset(3, 3)),
                            ]),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(children: <Widget>[
                                Container(
                                  child: Text(
                                    jeep['vehicle_plate_number'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    ' Driver: ${jeep["last_name"]}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "(" +
                                        DateFormat('yyyy-MM-dd – kk:mm').format(
                                            jeep["alley_time"].toDate()) +
                                        ")",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ]),
                              Container(
                                child: Icon(Icons.more_horiz),
                              )
                            ])))
                    .toList());
          });
    }
    if (MyApp.clicked_back == true && MyApp.clicked_forward == false) {
      return StreamBuilder(
          stream: alley = FirebaseFirestore.instance
              .collection('users')
              .where('user_type', isEqualTo: "Driver")
              .where('route_path', isEqualTo: driverPath)
              .where('vehicle_status', isEqualTo: 'ALLEY-TO-ORIGIN')
              .orderBy('alley_time', descending: false)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Center(child: Text('Failed to Retreive Info')));
            }
            if (snapshot.hasData == false) {
              return Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Center(child: CircularProgressIndicator()));
            }
            return Column(
                children: snapshot.data.docs
                    .map((jeep) => Container(
                        decoration: BoxDecoration(
                            color: driverPlate == jeep['vehicle_plate_number']
                                ? Colors.yellowAccent[700]
                                : Colors.yellow[700],
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.grey,
                                  offset: Offset(3, 3)),
                            ]),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(children: <Widget>[
                                Container(
                                  child: Text(
                                    jeep['vehicle_plate_number'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    ' Driver: ${jeep["last_name"]}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "(" +
                                        DateFormat('yyyy-MM-dd – kk:mm').format(
                                            jeep["alley_time"].toDate()) +
                                        ")",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ]),
                              Container(
                                child: Icon(Icons.more_horiz),
                              )
                            ])))
                    .toList());
          });
    }
    if (MyApp.clicked_forward == false && MyApp.clicked_back == false) {
      return Container(
          margin: EdgeInsets.only(top: 10),
          child:
              Center(child: Text('Select Alley Category To View Alley List')));
    }
  }

  broadcastLocation() {
    if (MyApp.broadcast == false) {
      return Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Text(
            'BROADCAST',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ));
    } else if (MyApp.broadcast == true) {
      return Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Text(
            'STOP',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ));
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            bottomOpacity: 0.0,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.yellow[700]),
            title: Text('Byahe App',
                style: TextStyle(
                    color: Colors.yellow[700], fontWeight: FontWeight.bold))),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [DrawerHead(), DrawerList()],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
                    child: Column(children: <Widget>[
          //Container(height: 50, child: TopBarMod()),
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
                          onPrimary: Colors.white,
                          primary: Colors.yellow[700],
                        ),
                        child: Text("Alley",
                            style: TextStyle(fontWeight: FontWeight.bold)))),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    width: 180,
                    height: 70,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => SetupCheck()));
                        },
                        style: ElevatedButton.styleFrom(
                            onPrimary: Colors.yellow[700],
                            primary: Colors.white),
                        child: Text("Check drivers",
                            style: TextStyle(fontWeight: FontWeight.bold))))
              ],
            ),
          ),
          Column(children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  border: Border.all(width: 2.0, color: Colors.yellow[700]),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                children: [
                  Container(
                      child: MyApp.broadcast
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Image.asset('assets/broadcast.gif'))
                          : Image.asset(
                              'assets/undraw_connected_world_wuay-removebg-preview.png')),
                  InkWell(
                      onTap: () {
                        if (MyApp.broadcast == true) {
                          context.read<Authenticate>().updateBroadCast(false);
                          stopLiveLocation();
                        } else if (MyApp.broadcast == false) {
                          context.read<Authenticate>().updateBroadCast(true);
                          getLiveLocation();
                        }
                        setState(() {
                          MyApp.broadcast = !MyApp.broadcast;
                        });
                      },
                      child: broadcastLocation()),
                ],
              ),
            ),
          ]),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: <Widget>[
                Container(
                    child: Text("$driverPath Alley",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold))),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          alley_state = "ALLEY-FROM-ORIGIN";
                          MyApp.clicked_forward = !MyApp.clicked_forward;
                          MyApp.clicked_back = false;
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 90, vertical: 15),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              border: Border.all(
                                  width: 2.0,
                                  color: MyApp.clicked_forward
                                      ? Colors.white
                                      : Colors.yellow[700]),
                              color: MyApp.clicked_forward
                                  ? Colors.yellow[700]
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Container(
                              child: Text('ALLEY-FROM-ORIGIN',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyApp.clicked_forward
                                          ? Colors.white
                                          : Colors.yellow[700]))))),
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        alley_state = 'ALLEY-TO-ORIGIN';
                        MyApp.clicked_back = !MyApp.clicked_back;
                        MyApp.clicked_forward = false;
                      });
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            border: Border.all(
                                width: 2.0,
                                color: MyApp.clicked_back
                                    ? Colors.white
                                    : Colors.yellow[700]),
                            color: MyApp.clicked_back
                                ? Colors.yellow[700]
                                : Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Container(
                            child: Text('ALLEY-TO-ORIGIN',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyApp.clicked_back
                                        ? Colors.white
                                        : Colors.yellow[700]))))),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                      onTap: () {
                        if (MyApp.alley == true) {
                          setState(() {
                            alley_state = 'DRIVING';
                          });
                          var clear_alleydate;
                          context.read<Authenticate>().updateVehicleStatus(
                              alley_state, clear_alleydate);
                        }
                        if ((MyApp.clicked_forward == true ||
                                MyApp.clicked_back == true) &&
                            MyApp.alley == false) {
                          context.read<Authenticate>().updateVehicleStatus(
                              alley_state, Timestamp.now() /*formattedDate*/);
                        }
                        if (MyApp.clicked_forward == false &&
                            MyApp.clicked_back == false &&
                            MyApp.alley == false) {
                          setState(() {
                            MyApp.alley = false;
                          });
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Please Select Alley Category"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('CLOSE'),
                                    )
                                  ],
                                );
                              });
                        }

                        setState(() {
                          MyApp.alley = !MyApp.alley;
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              border: Border.all(
                                width: 2.0,
                                color: (MyApp.alley)
                                    ? Colors.redAccent
                                    : Colors.yellow[700],
                              ),
                              color: (MyApp.alley)
                                  ? Colors.redAccent
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Container(child: alleyFunction()))),
                ),
                Container(child: alleyType()),
              ],
            ),
          ),
        ])))));
  }
}
