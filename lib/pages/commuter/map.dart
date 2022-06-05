import 'dart:async';
import 'dart:typed_data';
import 'package:byahe_app/main.dart';
import 'package:byahe_app/pages/commuter/reservevehicle.dart';
import 'package:byahe_app/pages/login_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:byahe_app/widgets/topbarmod.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as locate;
import 'package:provider/src/provider.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
// ignore: implementation_imports

// ignore: must_be_immutable
class Map extends StatefulWidget {
  var routeData;
  Map(this.routeData);
  @override
  _MapState createState() => _MapState(this.routeData);
}

class _MapState extends State<Map> {
  String useruid = FirebaseAuth.instance.currentUser.uid;
  Stream<DocumentSnapshot> driverInfo;
  var routeData;
  var latitude;
  var longitude;
  var email;
  var placeValue;
  var commuter_ping;
  var currentUserType;
  List driver = [];
  var driverLat;
  var driver_heading;
  var circle_accuracy;
  var cameraLat;
  var cameraLong;
  var driverLong;
  //DateTime dateNow = Timestamp.now().toDate();
  String formattedDate;
  //DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
  bool state = false;
  _MapState(this.routeData);
  StreamSubscription<QuerySnapshot> updateMarker;
  StreamSubscription<QuerySnapshot> notifyCommuter;
  StreamSubscription<QuerySnapshot> cameraChange;
  StreamSubscription _locationSubscription;
  locate.Location _locationTracker = locate.Location();
  GoogleMapController _controller;
  Marker marker;
  Marker marker2;
  Polyline drivertrack;
  PolylinePoints polylinepoints = PolylinePoints();
  List<Marker> usersMarkers = [];
  List<Polyline> polylinestracker = [];
  List<LatLng> forpolylines = [];
  List<PolylineWayPoint> waypoints = [];
  Circle circle;
  String apiKey = "AIzaSyC1MT12YRBBuDYKd1SMvFLOyiRM-PPE-wU";
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/jeep_icon.png");
    return byteData.buffer.asUint8List();
  }

  Future<Uint8List> getMarker2() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load('assets/red_arrow.png');
    return byteData.buffer.asUint8List();
  }

  //mao ni akong gichange mga part para live ang update niya sa map
  //kaning naa sa ibabaw na gicomment mao ni tong original na structure niya
  updateMarkerAndCircle(
      /*locate.LocationData newLocalData,*/ Uint8List imageData) {
    LatLng driverLocation;
    updateMarker = FirebaseFirestore.instance
        .collection('users')
        .where('vehicle_plate_number',
            isEqualTo: routeData['vehicle_plate_number'])
        .snapshots()
        .listen((querySnapshot) {
      querySnapshot.docChanges.forEach((element) {
        if (element.type == DocumentChangeType.added ||
            element.type == DocumentChangeType.modified) {
          driverLat = element.doc.data()['latitude'];
          driverLong = element.doc.data()['longitude'];
          driver_heading = element.doc.data()['driver_heading'];
          circle_accuracy = element.doc.data()['circle_accuracy'];
        }
      });
    });
    //print('Driver Coordinates: $driverLat, $driverLong');
    return setState(() {
      driverLocation = LatLng(driverLat, driverLong);
      marker = Marker(
          markerId: MarkerId(routeData['vehicle_plate_number']),
          position: driverLocation,
          rotation: driver_heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("arrow"),
          radius: circle_accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: driverLocation,
          fillColor: Colors.blue.withAlpha(70));
      /*drivertrack = Polyline(
        polylineId: PolylineId(routeData['vehicle_plate_number']),
        visible: true,
        points: forpolylines,
        color: Colors.red,
      );*/
    });
  }

  /*routeDirection() async {
    try {
      await FirebaseFirestore.instance
          .collection("subroutes")
          .where('route_path', isEqualTo: routeData['route_path'])
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          value.docs.forEach((element) {
            showrouteDirections(element.data());
          });
        }
      });
    } catch (e) {
      return e.toString();
    }
  }*/

  /*void showrouteDirections(coords) async {
    LatLng routepoint1 =
        LatLng(coords['point1'].latitude, coords['point1'].longitude);
    LatLng routepoint2 =
        LatLng(coords['point2'].latitude, coords['point2'].longitude);
    LatLng routepoint3 =
        LatLng(coords['point3'].latitude, coords['point3'].longitude);
    LatLng routepoint4 =
        LatLng(coords['point4'].latitude, coords['point4'].longitude);
    LatLng routepoint5 =
        LatLng(coords['point5'].latitude, coords['point5'].longitude);
    LatLng routepoint6 =
        LatLng(coords['point6'].latitude, coords['point6'].longitude);
    LatLng routepoint7 =
        LatLng(coords['point7'].latitude, coords['point7'].longitude);
    LatLng routepoint8 =
        LatLng(coords['point8'].latitude, coords['point8'].longitude);
    forpolylines.add(routepoint1);
    forpolylines.add(routepoint2);
    forpolylines.add(routepoint3);
    forpolylines.add(routepoint4);
    forpolylines.add(routepoint5);
    forpolylines.add(routepoint6);
    forpolylines.add(routepoint7);
    forpolylines.add(routepoint8);
    drivertrack = Polyline(
      polylineId: PolylineId(coords['route_path']),
      visible: true,
      points: forpolylines,
      color: Colors.red,
    );
    polylinestracker.add(drivertrack);
  }*/

  void updateMarkerCommuter(
      locate.LocationData newLocalData, Uint8List imageData2) {
    LatLng commuter = LatLng(latitude, longitude);
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    //print(commuter);
    print(latlng);
    this.setState(() {
      marker2 = Marker(
          markerId: MarkerId(email.toString()),
          position: commuter, //latlng,
          rotation: newLocalData.heading,
          infoWindow: InfoWindow(title: '$email pinged'),
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData2));
    });
  }

  fetchCurrentUser() async {
    dynamic result = await context.read<Authenticate>().retrieveUsertype();

    if (result == null) {
      print('Unable to retrieve user type');
    } else {
      if (mounted) {
        currentUserType = result;
      }
    }
  }

  getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
        updateMarker.cancel();
        cameraChange.cancel();
      }
      cameraChange = FirebaseFirestore.instance
          .collection('users')
          .where('vehicle_plate_number',
              isEqualTo: routeData['vehicle_plate_number'])
          .snapshots()
          .listen((querySnapshot) {
        querySnapshot.docChanges.forEach((element) {
          if (element.type == DocumentChangeType.added ||
              element.type == DocumentChangeType.modified) {
            cameraLat = element.doc.data()['latitude'];
            cameraLong = element.doc.data()['longitude'];
          }
        });
      });

      return _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  bearing: 192.345345345,
                  target: LatLng(cameraLat, cameraLong),
                  tilt: 0,
                  zoom: 17)));
          updateMarkerAndCircle(/*newLocalData,*/ imageData);
          usersMarkers.add(marker);
          //polylinestracker.add(drivertrack);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  void getCommuterLocation() async {
    try {
      Uint8List imageData2 = await getMarker2();
      var location = await _locationTracker.getLocation();
      updateMarkerCommuter(location, imageData2);
      await FirebaseFirestore.instance.collection('users').doc(useruid).set({
        'latitude': location.latitude,
        'longitude': location.longitude,
      }, SetOptions(merge: true));
      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }
      usersMarkers.add(marker2);
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLat();
    fetchLong();
    fetchEmail();
    fetchCurrentUser();
    fetchPingStatus();
    //routeDirection();
    var initializationSettingAndroid =
        new AndroidInitializationSettings('ic_launcher');
    var initializationSettings =
        new InitializationSettings(android: initializationSettingAndroid);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectnotification);
    if (useruid != routeData['uid']) {
      notifyCommuter = FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: useruid)
          .snapshots()
          .listen((query) {
        query.docChanges.forEach((element) {
          if (element.type == DocumentChangeType.added ||
              element.type == DocumentChangeType.modified) {
            if (element.doc.data()['ping_status'] != 'Cancelled' &&
                element.doc.data()['ping_status'] != 'Pending' &&
                element.doc.data()['ping_status'] != null) {
              alertCommuter();
            }
          }
        });
      });
    }
  }

  Future onSelectnotification(String payload) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Driver Responded'),
              content: Text(payload),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Map(routeData)));
                    },
                    child: Text('OK'))
              ],
            ));
  }

  Future alertCommuter() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        "driver response", "onboard or reject",
        channelDescription: "notify commuter when responded",
        enableVibration: true,
        playSound: true,
        importance: Importance.max,
        priority: Priority.high);
    NotificationDetails platformChannelSpecifics =
        new NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      "Driver Responded To Ping",
      "View or Refresh Map to see the response",
      platformChannelSpecifics,
      payload: "Refresh Map",
    );
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    if (updateMarker != null) {
      updateMarker.cancel();
      cameraChange.cancel();
    }
    //queueStatus.dispose();
    super.dispose();
  }

  fetchLat() async {
    dynamic results = await context.read<Authenticate>().getLat();

    if (results == null) {
      print('Unable to retrieve commuter info');
    } else {
      if (mounted) {
        setState(() {
          latitude = results;
        });
      }
    }
  }

  fetchLong() async {
    dynamic results = await context.read<Authenticate>().getLong();

    if (results == null) {
      print('Unable to retrieve commuter info');
    } else {
      if (mounted) {
        setState(() {
          longitude = results;
        });
      }
    }
  }

  fetchPingStatus() async {
    dynamic result = await context.read<Authenticate>().getPingStatus();

    if (result == null) {
      print('Unable to retreive commuter ping status (map.dart)');
    } else {
      if (mounted) {
        setState(() {
          commuter_ping = result;
        });
      }
    }
  }

  fetchEmail() async {
    dynamic results = await context.read<Authenticate>().getEmail();

    if (results == null) {
      print('Unable to retrieve commuter info');
    } else {
      if (mounted) {
        setState(() {
          email = results;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(routeData['uid'])
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(
                child: Center(child: Text('Failed to Retreive Info')));
          }
          if (snapshot.hasData == false) {
            return Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Center(child: CircularProgressIndicator()));
          }
          /*if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
            );
          }*/
          return WillPopScope(
              onWillPop: () async => state
                  ? showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('WARNING'),
                          content: Text(
                              'You are not able to exit on this page while pinging!'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('CLOSE'),
                            )
                          ],
                        );
                      })
                  : true,
              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    bottomOpacity: 0.0,
                    elevation: 0.0,
                    iconTheme: IconThemeData(color: Colors.yellow[700]),
                    title: Text('Byahe App',
                        style: TextStyle(
                            color: Colors.yellow[700],
                            fontWeight: FontWeight.bold)),
                  ),
                  backgroundColor: state ? Colors.grey[200] : null,
                  body: SingleChildScrollView(
                      child: SafeArea(
                          child: Container(
                    child: Column(
                      children: <Widget>[
                        // Container(height: 50, child: TopBarMod()), //MAIN TOP BAR
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: state
                                        ? Colors.redAccent
                                        : Colors.yellow[700],
                                    width: 2)),
                            height: 400.0,
                            child: GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(snapshot.data['latitude'],
                                      snapshot.data['longitude'])),
                              markers: Set.of(usersMarkers),
                              polylines: Set.of(polylinestracker),
                              circles: Set.of((circle != null) ? [circle] : []),
                              onMapCreated:
                                  (GoogleMapController controller) async {
                                _controller = controller;
                                getCurrentLocation();
                                /*if (MyApp.ping == true) {
                                  getCommuterLocation();
                                }*/
                              },
                            )),
                        Container(
                            child: Column(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.all(10),
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Map(routeData)));
                                    },
                                    child: Image.asset(
                                      'assets/reload.png',
                                      width: 20,
                                      height: 20,
                                    ))),
                            Column(children: [
                              if (commuter_ping != "Onboard" &&
                                  commuter_ping != "Rejected")
                                if (state)
                                  Text('PINGING ...',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                              if (commuter_ping == "Rejected")
                                Text('Rejected',
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              if (commuter_ping == "Onboard")
                                Text('Onboard',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold))
                            ]),
                            Container(
                                child: (commuter_ping != "Onboard")
                                    ? state
                                        ? Image.asset(
                                            'assets/car_ride_tester.gif',
                                            height: 100)
                                        : Image.asset(
                                            'assets/undraw_fast_car_p4cu-removebg-preview.png',
                                            height: 100)
                                    : Image.asset(
                                        'assets/undraw_fast_car_p4cu-removebg-preview.png',
                                        height: 100)),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Column(children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                          child: Row(
                                        children: <Widget>[
                                          Text("Status : ",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            "${snapshot.data['vehicle_status']}",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.green,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                      (snapshot.data['alley_time'] == null)
                                          ? Container(
                                              child: Row(children: <Widget>[
                                              Text(
                                                "Vehicle Plate Number: ",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${snapshot.data['vehicle_plate_number']}",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ]))
                                          : Column(children: [
                                              Container(
                                                  child: Row(children: <Widget>[
                                                Text(
                                                  "Vehicle Plate Number: ",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "${snapshot.data['vehicle_plate_number']}",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ])),
                                              Container(
                                                  child: Row(children: <Widget>[
                                                Text(
                                                  "Time Queued: ",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  DateFormat(
                                                          'yyyy-MM-dd – kk:mm')
                                                      .format(snapshot
                                                          .data['alley_time']
                                                          .toDate())
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ]))
                                            ])
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            child: Row(
                                          children: <Widget>[
                                            Text(
                                              "Seats Occupied : ",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "${snapshot.data['current_occupied'].toString()}/${snapshot.data['seats_avail'].toString()}",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.green,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ))
                                      ]),
                                  Row(children: <Widget>[
                                    Container(
                                        child: Wrap(
                                            direction: Axis.vertical,
                                            children: <Widget>[
                                          Text(
                                            "ROUTE : ",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${snapshot.data['route_path']}",
                                            style: TextStyle(
                                                color: Colors.green,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]))
                                  ])
                                ])),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: (commuter_ping != "Onboard")
                                  ? state
                                      ? Container(
                                          height: 50,
                                          width: 200,
                                          margin: EdgeInsets.all(10),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  cancelPing();
                                                  context
                                                      .read<Authenticate>()
                                                      .clearPing();
                                                  MyApp.ping = false;
                                                  state = false;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.redAccent,
                                                  onPrimary: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12), // <-- Radius
                                                  ),
                                                  side: BorderSide(
                                                      color: Colors.redAccent)),
                                              child: Text('CANCEL NOW!')))
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            ElevatedButton(
                                                onPressed: () {
                                                  if (currentUserType ==
                                                      "Driver") {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                "Driver can't ping"),
                                                            content: Text(
                                                                'This function is for commuters only'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    'CLOSE'),
                                                              )
                                                            ],
                                                          );
                                                        });
                                                  } else if (currentUserType ==
                                                      "Commuter") {
                                                    setState(() {
                                                      savePing();
                                                      convertLatLng();
                                                      //getCoordinates();
                                                      //getCommuterLocation();
                                                      state = true;
                                                      context
                                                          .read<Authenticate>()
                                                          .updatePing(
                                                              routeData['uid'],
                                                              Timestamp.now());
                                                      MyApp.ping = true;
                                                    });
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.white,
                                                    onPrimary:
                                                        Colors.yellow[700],
                                                    side: BorderSide(
                                                        color: Colors
                                                            .yellow[700])),
                                                child: Text(
                                                  "QUEUE NOW!",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            ElevatedButton(
                                                onPressed: () {
                                                  if (routeData['uid'] ==
                                                      useruid) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                "You can't book to yourself"),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    'CLOSE'),
                                                              )
                                                            ],
                                                          );
                                                        });
                                                  } else {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ReserveVehicle(
                                                                    routeData)));
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    onPrimary:
                                                        Colors.yellow[700],
                                                    primary: Colors.white,
                                                    side: BorderSide(
                                                        color: Colors
                                                            .yellow[700])),
                                                child: Text("RESERVE NOW!",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)))
                                          ],
                                        )
                                  : Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 1),
                                    ),
                            )
                          ],
                        ))
                      ],
                    ),
                  )))));
        });
  }

  Future<void> savePing() async {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    try {
      final locate.LocationData currentLocation =
          await _locationTracker.getLocation();
      await FirebaseFirestore.instance.collection('users').doc(useruid).set({
        'latitude': currentLocation.latitude,
        'longitude': currentLocation.longitude,
      }, SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
  }

  Future convertLatLng() async {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    try {
      final locate.LocationData currentLocation =
          await _locationTracker.getLocation();
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentLocation.latitude, currentLocation.longitude);
      Placemark place = placemarks[0];
      placeValue = '${place.street}, ${place.locality}';
      await FirebaseFirestore.instance.collection('users').doc(useruid).set({
        'place_in_words': placeValue,
      }, SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
  }

  getCoordinates() async {
    Uint8List imageData2 = await getMarker2();
    if (latitude != null && longitude != null) {
      setState(() {
        usersMarkers.add(Marker(
            markerId: MarkerId(email),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(
              title: '$email pinged',
            ),
            icon: BitmapDescriptor.fromBytes(imageData2)));
      });
    }
  }

  cancelPing() {
    Marker mark = usersMarkers
        .firstWhere((mark) => mark.markerId.value == email, orElse: () => null);
    setState(() {
      usersMarkers.remove(mark);
    });
  }
}
