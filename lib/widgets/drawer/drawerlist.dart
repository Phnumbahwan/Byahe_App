import 'package:byahe_app/main.dart';
import 'package:byahe_app/pages/commuter/locationselection.dart';
import 'package:byahe_app/pages/commuter/reservedetails.dart';
import 'package:byahe_app/pages/driver/onboard.dart';
import 'package:byahe_app/pages/driver/setup-alley.dart';
import 'package:byahe_app/pages/login/loginpage.dart';
import 'package:byahe_app/pages/login_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class DrawerList extends StatefulWidget {
  // const DrawerList({ Key? key }) : super(key: key);

  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  var userType;
  @override
  initState() {
    super.initState();
    fetchUserType();
  }

  fetchUserType() async {
    dynamic result = await context.read<Authenticate>().retrieveUsertype();
    if (result == null) {
      print('Unable to retreive user_type (drawerlist.dart)');
    } else {
      setState(() {
        userType = result;
      });
    }
  }

  toOnboard() {
    if (MyApp.inboard == false) {
      return ListTile(
          leading: Icon(Icons.check_box_outline_blank), title: Text('Onboard'));
    } else {
      return ListTile(
          leading: Icon(Icons.location_searching), title: Text('Selection'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: (userType == 'Commuter')
            ? Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.book_online),
                    title: Text('Booking Requests'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReserveDetails()));
                    },
                  ),
                  // ListTile(
                  //   leading: Icon(Icons.location_searching),
                  //   title: Text('Selection'),
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => LocationSelection()));
                  //   },
                  // ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Log Out'),
                    onTap: () async {
                      String status = "OFFLINE";
                      //Navigator.pop(context);
                      context.read<Authenticate>().updateUserStatus("OFFLINE");
                      await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                      await FirebaseAuth.instance.signOut();
                      /*Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));*/
                    },
                  ),
                ],
              )
            : Column(
                children: [
                  InkWell(
                    child: toOnboard(),
                    onTap: () {
                      if (MyApp.inboard == false) {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Onboard()));
                        MyApp.inboard = true;
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LocationSelection()));
                        MyApp.inboard = false;
                      }
                    },
                  ),
                  InkWell(
                    child: ListTile(
                        leading: Icon(Icons.logout), title: Text('Log Out')),
                    onTap: () {
                      if (MyApp.broadcast == true) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Broadcast Location is still On"),
                                content: Text('Turn it off before logging out'),
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
                        String status = "OFFLINE";
                        context.read<Authenticate>().updateUserStatus(status);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginPage()));
                        FirebaseAuth.instance.signOut();
                      }
                    },
                  ),
                ],
              ));
  }
}
