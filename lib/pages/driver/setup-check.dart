import 'package:byahe_app/data/data.dart';
import 'package:byahe_app/pages/driver/setup-alley.dart';
import 'package:byahe_app/pages/login_auth.dart';
import 'package:byahe_app/widgets/drawer/drawerheader.dart';
import 'package:byahe_app/widgets/drawer/drawerlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/topbarmod.dart';
import 'package:byahe_app/widgets/driver/navigationalcontainer.dart';
import 'package:provider/src/provider.dart';

class SetupCheck extends StatefulWidget {
  // const SetupCheck({ Key? key }) : super(key: key);

  @override
  _SetupCheckState createState() => _SetupCheckState();
}

class _SetupCheckState extends State<SetupCheck> {
  String pageName = 'Set-up';
  int total_drivers_area = 55;
  int total_drivers_route = 10;
  var total_drivers;
  List routes = [];
  var currentDriverRoute;
  var activeSameRoute;
  var sameRouteCounter = 0;
  Stream<QuerySnapshot> sameRoute;

  @override
  initState() {
    super.initState();
    fetchTotalDrivers();
    fetchActiveDriversRoute();
    fetchCurrentDriverRoute();
  }

  fetchTotalDrivers() async {
    dynamic result =
        await context.read<Authenticate>().getTotalDriversRegistered();
    if (result == null) {
      print('Unable to get total drivers active (setup-check.dart');
    } else {
      if (mounted) {
        setState(() {
          total_drivers = result;
        });
      }
    }
  }

  fetchCurrentDriverRoute() async {
    dynamic result = await context.read<Authenticate>().getDriverRoute();
    if (result == null) {
      print('Unable to retreive currentDriverRoute (setup-check.dart');
    } else {
      if (mounted) {
        setState(() {
          currentDriverRoute = result;
        });
      }
    }
  }

  fetchActiveDriversRoute() async {
    dynamic result = await context
        .read<Authenticate>()
        .getTotalDriversInRoute(currentDriverRoute);
    if (result == null) {
      print('Unable to retreive activedriverRoute (setup-check.dart)');
    } else {
      if (mounted) {
        setState(() {
          activeSameRoute = result;
        });
      }
    }
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
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => SetupAlley()));
                        },
                        style: ElevatedButton.styleFrom(
                            onPrimary: Colors.yellow[700],
                            primary: Colors.white),
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
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => SetupCheck()));
                  },
                  child: Image.asset(
                    'assets/reload.png',
                    width: 40,
                  ))),
          Container(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(30),
                    child: Column(children: <Widget>[
                      Text('TOTAL DRIVERS IN YOUR AREA',
                          style: TextStyle(
                              color: Colors.yellow[700],
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      Text(
                        total_drivers.toString(),
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.yellow[700],
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      Text('TOTAL DRIVERS ACTIVE IN THE SAME ROUTE',
                          style: TextStyle(
                              color: Colors.yellow[700],
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      StreamBuilder(
                          stream: sameRoute = FirebaseFirestore.instance
                              .collection('users')
                              .where('route_path',
                                  isEqualTo: currentDriverRoute)
                              .where('user_type', isEqualTo: "Driver")
                              .where('status', isEqualTo: 'ONLINE')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Failed to Retreive Info',
                                  style: TextStyle(color: Colors.white));
                            }
                            if (snapshot.hasData == false) {
                              return CircularProgressIndicator();
                            }
                            routes = snapshot.data.docs;
                            return Text(
                              (routes.length.toString()),
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.yellow[700],
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                            );
                          })
                    ])),
              ],
            ),
          )
        ])))));
  }
}
