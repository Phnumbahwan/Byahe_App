import 'dart:math';

import 'package:byahe_app/pages/commuter/locationselection.dart';
import 'package:byahe_app/pages/register/registerdriverconfirmation.dart';
import 'package:byahe_app/widgets/closebutton.dart';
import 'package:byahe_app/pages/login_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/pages/login/loginpage.dart';

class RegisterDriver extends StatefulWidget {
  @override
  _RegisterDriverState createState() => _RegisterDriverState();
}

class _RegisterDriverState extends State<RegisterDriver> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController fnameController = new TextEditingController();
  TextEditingController lnameController = new TextEditingController();
  TextEditingController jlineController = new TextEditingController();
  TextEditingController jrouteController = new TextEditingController();
  TextEditingController mobnumController = new TextEditingController();
  TextEditingController platenumController = new TextEditingController();
  TextEditingController routepathController = new TextEditingController();
  TextEditingController seatcapController = new TextEditingController();
  List locationList = [];
  List routeList = [];
  final String userType = "Driver";
  var status = 'ONLINE';
  String useruid;
  var selectedJeepLine = 'none';
  var selectedRoute = 'none';
  var selectedPath = 'none';
  var vehicle_status = 'DRIVING';
  int current_occupied = 0;
  bool broadcast = false;

  @override
  void initState() {
    super.initState();
    fetchLocationList();
    fetchSubrouteList();
  }

  fetchLocationList() async {
    dynamic result = await context.read<Authenticate>().getLocationList();
    if (result == null) {
      print('Unable to retreive location list (registerdriver.dart)');
    } else {
      if (mounted) {
        setState(() {
          locationList = result;
        });
      }
    }
  }

  fetchSubrouteList() async {
    dynamic result = await context.read<Authenticate>().getSubrouteList();
    if (result == null) {
      print('Unable to retreive route list (registerdriver.dart)');
    } else {
      if (mounted) {
        setState(() {
          routeList = result;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        children: <Widget>[
          SafeArea(
            child: CloseButtonBlack(),
          ),
          Text(
            'BYAHE',
            style: TextStyle(
              fontFamily: 'Thasadith',
              fontWeight: FontWeight.bold,
              color: Colors.yellow[700],
              fontSize: 60,
            ),
          ),
          Image.asset('assets/undraw_navigator_a479-removebg-preview.png'),
          Container(
              child: Text(
            "Please fillup this pre-registration form. And get a copy of your confirmation code. After that wait for our team to contact you and settle for an appointment",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17),
          )),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[700]),
                        borderRadius: BorderRadius.circular(17)),
                    labelText: "Email",
                    border: OutlineInputBorder()),
              )),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[700]),
                        borderRadius: BorderRadius.circular(17)),
                    labelText: "Password",
                    border: OutlineInputBorder()),
              )),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: fnameController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[700]),
                        borderRadius: BorderRadius.circular(17)),
                    labelText: "First Name",
                    border: OutlineInputBorder()),
              )),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: lnameController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[700]),
                        borderRadius: BorderRadius.circular(17)),
                    labelText: "Last Name",
                    border: OutlineInputBorder()),
              )),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: DropdownButtonFormField(
                isExpanded: true,
                items: locationList
                    .map((locations) => new DropdownMenuItem<String>(
                        value: locations['jeep_line'],
                        child: Text(
                          locations['jeep_line'],
                          overflow: TextOverflow.ellipsis,
                        )))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedJeepLine = value;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow[700]),
                      borderRadius: BorderRadius.circular(17)),
                  labelText: "Jeepney Line",
                  border: OutlineInputBorder(),
                )),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: DropdownButtonFormField(
                isExpanded: true,
                items: routeList
                    .map((routes) => new DropdownMenuItem<String>(
                        value: routes['jeepney_route'],
                        child: Text(
                          routes['jeepney_route'],
                          overflow: TextOverflow.ellipsis,
                        )))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRoute = value;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow[700]),
                      borderRadius: BorderRadius.circular(17)),
                  labelText: "Jeepney Route",
                  border: OutlineInputBorder(),
                )),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: DropdownButtonFormField(
                isExpanded: true,
                items: routeList
                    .map((path) => new DropdownMenuItem<String>(
                        value: path['route_path'],
                        child: Text(
                          path['route_path'],
                          overflow: TextOverflow.ellipsis,
                        )))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPath = value;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow[700]),
                      borderRadius: BorderRadius.circular(17)),
                  labelText: "Route Path(Ex. Gusa-Cugman-Lapasan...",
                  border: OutlineInputBorder(),
                )),
          ),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                maxLength: 11,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: mobnumController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[700]),
                        borderRadius: BorderRadius.circular(17)),
                    labelText: "Contact Number",
                    border: OutlineInputBorder()),
              )),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                maxLength: 2,
                keyboardType: TextInputType.number,
                controller: seatcapController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[700]),
                        borderRadius: BorderRadius.circular(17)),
                    labelText: "Seat Capacity",
                    border: OutlineInputBorder()),
              )),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: platenumController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[700]),
                        borderRadius: BorderRadius.circular(17)),
                    labelText: "Vehicle plate number",
                    border: OutlineInputBorder()),
              )),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 30),
            child: ElevatedButton(
              onPressed: () {
                final String email = emailController.text.trim();
                final String password = passwordController.text.trim();
                final String fname = fnameController.text.trim();
                final String lname = lnameController.text.trim();
                final String jeepline = jlineController.text.trim();
                final String jeeproute = jrouteController.text.trim();
                final String mobnum = mobnumController.text.trim();
                final String platenum = platenumController.text.trim();
                final String routepath = routepathController.text.trim();
                final String seatcap = seatcapController.text.trim();
                if (email.isEmpty |
                        platenum.isEmpty |
                        fname.isEmpty |
                        lname.isEmpty ||

                    //jeepline.isEmpty |

                    //jeeproute.isEmpty |
                    mobnum.isEmpty |
                        password.isEmpty |
                        //routepath.isEmpty |
                        seatcap.isEmpty ||
                    selectedJeepLine == 'none' ||
                    selectedRoute == 'none' ||
                    selectedPath == 'none') {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Complete the fields to proceed"),
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
                } else {
                  try {
                    context
                        .read<Authenticate>()
                        .signupDriver(email, password)
                        .then((value) async {
                      User user = FirebaseAuth.instance.currentUser;
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(user.uid)
                          .set({
                        'uid': user.uid,
                        'user_type': userType,
                        'email': email,
                        'password': password,
                        'first_name': fname,
                        'last_name': lname,
                        'jeepney_line': selectedJeepLine, //jeepline,
                        'jeepney_route': selectedRoute, //jeeproute,
                        'route_path': selectedPath, //routepath,
                        'seats_avail': int.parse(seatcap),
                        'mobile_number': int.parse(mobnum),
                        'vehicle_plate_number': platenum,
                        'vehicle_status': vehicle_status,
                        'broadcast': broadcast,
                        'current_occupied': current_occupied,
                        'status': status,
                        'alley_time': null,
                      });
                    });
                    return showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Successfully Signed Up'),
                            actions: <Widget>[
                              ElevatedButton(
                                  child: Text("CLOSE"),
                                  onPressed: () {
                                    /*context
                                      .read<Authenticate>()
                                      .login(email, password);*/
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LocationSelection()),
                                        (ModalRoute.withName('/')));
                                    Navigator.pop(context);
                                    //Navigator.of(context).pop();
                                  })
                            ],
                          );
                        });
                  } catch (e) {
                    return showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            actionsOverflowDirection: VerticalDirection.down,
                            title: Text(e.toString()),
                            actions: <Widget>[
                              ElevatedButton(
                                  child: Text("CLOSE"),
                                  onPressed: () {
                                    /*context
                                        .read<Authenticate>()
                                        .login(email, password);*/
                                    Navigator.of(context).pop();
                                  })
                            ],
                          );
                        });
                  }

                  /*return showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Successfully Signed Up'),
                          actions: <Widget>[
                            ElevatedButton(
                                child: Text("CLOSE"),
                                onPressed: () {
                                  /*context
                                      .read<Authenticate>()
                                      .login(email, password);*/
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LocationSelection()),
                                      (ModalRoute.withName('/')));
                                  Navigator.pop(context);
                                  //Navigator.of(context).pop();
                                })
                          ],
                        );
                      });*/
                }
              },
              /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterDriverConfirmation()),
                );*/
              child: Text("CONFIRM"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.yellow[700],
                  fixedSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          )
        ],
      ),
    )));
  }
}
