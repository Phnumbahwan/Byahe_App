import 'dart:async';
import 'dart:typed_data';
import 'package:byahe_app/main.dart';
import 'package:byahe_app/pages/commuter/reservevehicle.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/topbarmod.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Map extends StatefulWidget {
  var route;
  Map(this.route);
  @override
  _MapState createState() => _MapState(this.route);
}

class _MapState extends State<Map> {
  var route;
  _MapState(this.route);
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  GoogleMapController _controller;
  Marker marker;
  Marker marker2;
  Circle circle;
  Circle circle2;

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/red_arrow.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    LatLng latlng2 = LatLng(8.473428, 124.607859);
    print(latlng);
    this.setState(() {
      marker2 = Marker(
          markerId: MarkerId("home2"),
          position: latlng2,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("arrow"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  static final CameraPosition initialLocation =
      CameraPosition(target: LatLng(12.4155121, -123.4310376), zoom: 14.4746);

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();
      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller
              .animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
                  bearing: 192.345345345,
                  // target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  target: LatLng(8.473428, 124.607859),
                  tilt: 0,
                  zoom: 18)));
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
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
    return WillPopScope(
        onWillPop: () async => route['queue']
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
            backgroundColor: route['queue'] ? Colors.grey[200] : null,
            body: SingleChildScrollView(
                child: SafeArea(
                    child: Container(
              child: Column(
                children: <Widget>[
                  Container(height: 50, child: TopBarMod()), //MAIN TOP BAR
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: route['queue']
                                  ? Colors.redAccent
                                  : Colors.yellow[700],
                              width: 2)),
                      height: 400.0,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: initialLocation,
                        markers: Set.of((marker != null) & (marker2 != null)
                            ? [marker, marker2]
                            : []),
                        circles: Set.of((circle != null) ? [circle] : []),
                        onMapCreated: (GoogleMapController controller) {
                          _controller = controller;
                          getCurrentLocation();
                        },
                      )),
                  Container(
                      child: Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(top: 10),
                          child: route['queue']
                              ? Text('PINGING ...',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold))
                              : null),
                      Container(
                          child: route['queue']
                              ? Image.asset('assets/car_ride_tester.gif',
                                  height: 100)
                              : Image.asset(
                                  'assets/undraw_fast_car_p4cu-removebg-preview.png',
                                  height: 100)),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Column(children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    child: Row(
                                  children: <Widget>[
                                    Text("Status : ",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      "${route['vehicle_status']}",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.green,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                                Container(
                                    child: Row(children: <Widget>[
                                  Text(
                                    "Vehicle Plate Number: ",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${route['vehicle_plate_number']}",
                                    style: TextStyle(
                                        fontSize: 10,
                                        decoration: TextDecoration.underline,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]))
                              ],
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      child: Row(children: <Widget>[
                                    Text(
                                      "Time to leave : ",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${route['time_to_leave']} mins/s left",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.orange[700],
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]))
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Seats availability : ",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${route['seats_availability']}/10",
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
                                      "${route['route_destination']}",
                                      style: TextStyle(
                                          color: Colors.green,
                                          decoration: TextDecoration.underline,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]))
                            ])
                          ])),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: route['queue']
                              ? Container(
                                  height: 50,
                                  width: 200,
                                  margin: EdgeInsets.all(10),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          route['queue'] = !route['queue'];
                                          MyApp.ping = route['queue'];
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.redAccent,
                                          onPrimary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
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
                                          setState(() {
                                            route['queue'] = !route['queue'];
                                            MyApp.ping = route['queue'];
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                            onPrimary: Colors.yellow[700],
                                            side: BorderSide(
                                                color: Colors.yellow[700])),
                                        child: Text(
                                          "QUEUE NOW!",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    ElevatedButton(
                                        onPressed: () {
                                          // Navigator.pushNamed(context, '/reservevehicle');
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReserveVehicle()));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            onPrimary: Colors.yellow[700],
                                            primary: Colors.white,
                                            side: BorderSide(
                                                color: Colors.yellow[700])),
                                        child: Text("RESERVE NOW!",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))
                                  ],
                                ))
                    ],
                  ))
                ],
              ),
            )))));
  }
}
