import 'package:byahe_app/pages/driver/pending.dart';
import 'package:byahe_app/pages/login_auth.dart';
import 'package:byahe_app/widgets/drawer/drawerheader.dart';
import 'package:byahe_app/widgets/drawer/drawerlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/topbarmod.dart';
import 'package:byahe_app/widgets/driver/navigationalcontainer.dart';
import 'package:byahe_app/data/data.dart';
import 'package:provider/src/provider.dart';

class Onboard extends StatefulWidget {
  // const Onboard({ Key? key }) : super(key: key);

  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int jeepcapacity = 12;
  var driverPlate;
  int current_occupied;
  Stream<QuerySnapshot> totalonboard;
  String useruid = FirebaseAuth.instance.currentUser.uid;
  List getPingsOnboard = [];

  // ignore: missing_return
  Color checkVacant(int occupy) {
    double low = jeepcapacity * 0.5;
    double mid = jeepcapacity * 0.8;
    int high = jeepcapacity * 1;
    if (occupy <= low) {
      return Colors.greenAccent;
    } else if (occupy <= mid && occupy > low) {
      return Colors.yellow[700];
    } else if (occupy > mid && occupy <= high) {
      return Colors.redAccent;
    }
  }

  @override
  initState() {
    super.initState();
    fetchDriverPlate();
    fetchOnboardPing();
    fetchCurrentOccupied();
  }

  fetchOnboardPing() async {
    dynamic result = await context.read<Authenticate>().getAcceptedPingList();
    if (result == null) {
      print('Unable to get Onboard Ping (onboard.dart)');
    } else {
      if (mounted) {
        setState(() {
          getPingsOnboard = result;
        });
      }
    }
  }

  fetchCurrentOccupied() async {
    dynamic result = await context.read<Authenticate>().getOccupied();
    if (result == null) {
      print('Unable to retreive current occupied (onboard.dart)');
    } else {
      if (mounted) {
        setState(() {
          current_occupied = result;
        });
      }
    }
  }

  fetchDriverPlate() async {
    dynamic result = await context.read<Authenticate>().getPlate();
    if (result == null) {
      print('Unable to get driver plate (onboard.dart)');
    } else {
      if (mounted) {
        setState(() {
          driverPlate = result;
        });
      }
    }
  }

  String pageName = 'Onboard';
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
          Container(
            child: Text(
              this.pageName.toUpperCase(),
              style: TextStyle(color: Colors.yellowAccent[700], fontSize: 30),
            ),
          ),
          NavigationalContainer(this.pageName),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: InkWell(
                    onTap: () {
                      if (current_occupied >= 0) {
                        setState(() {
                          current_occupied--;
                        });
                        context
                            .read<Authenticate>()
                            .updateOccupied(current_occupied);
                      } else if (current_occupied < 0) {
                        context.read<Authenticate>().updateOccupied(0);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Onboard Already Empty"),
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
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.yellow[700],
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          'Unload Anonymous-',
                          style: TextStyle(color: Colors.white),
                        ))),
              ),
              StreamBuilder(
                  stream: totalonboard = FirebaseFirestore.instance
                      .collection('users')
                      .where('uid', isEqualTo: useruid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Container(
                          child:
                              Center(child: Text('Failed to Retreive Info')));
                    }
                    if (snapshot.hasData == false) {
                      return Container(
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: Center(child: CircularProgressIndicator()));
                    }
                    return Container(
                      alignment: Alignment.topLeft,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      child: Row(
                        children: snapshot.data.docs
                            .map(
                              (totalonboard) => Text(
                                  totalonboard['current_occupied'].toString() +
                                      '/' +
                                      totalonboard['seats_avail'].toString(),
                                  style: TextStyle(
                                      color: checkVacant(commuterinfo.length),
                                      fontWeight: FontWeight.bold)),
                            )
                            .toList(),
                      ),
                    );
                  }),
            ],
          ),
          Container(
              child: StreamBuilder(
                  stream: totalonboard = FirebaseFirestore.instance
                      .collection('users')
                      .where('pinged_driver', isEqualTo: useruid)
                      .where('user_type', isEqualTo: "Commuter")
                      .where('ping_status', isEqualTo: "Onboard")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Container(
                          child:
                              Center(child: Text('Failed to Retreive Info')));
                    }
                    if (snapshot.hasData == false) {
                      return Container(
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: Center(child: CircularProgressIndicator()));
                    }
                    return Column(
                      children: snapshot.data.docs
                          .map((commuter) => Container(
                              decoration: BoxDecoration(
                                  color: Colors.yellow[700],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        color: Colors.grey,
                                        offset: Offset(3, 3)),
                                  ]),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(children: <Widget>[
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Icon(
                                                Icons.account_circle_outlined)),
                                        Container(
                                          width: 215,
                                          child: (commuter['full_name'] != null)
                                              ? Text(
                                                  'Commuter: ' +
                                                      commuter['full_name'],
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : Text('Fetching Name...',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                        )
                                      ]),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<Authenticate>()
                                            .resetPing(commuter['uid']);
                                        setState(() {
                                          current_occupied--;
                                        });
                                        context
                                            .read<Authenticate>()
                                            .updateOccupied(current_occupied);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Image.asset(
                                          'assets/remove.png',
                                          fit: BoxFit.contain,
                                          width: 50,
                                        ),
                                      ),
                                    )
                                  ])))
                          .toList(),
                    );
                  }))
        ])))));
  }
}
