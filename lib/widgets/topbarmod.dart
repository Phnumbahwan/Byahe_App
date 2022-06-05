import 'package:byahe_app/main.dart';
import 'package:byahe_app/pages/commuter/locationselection.dart';
import 'package:byahe_app/pages/driver/onboard.dart';
import 'package:byahe_app/pages/login/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:byahe_app/pages/login_auth.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class TopBarMod extends StatefulWidget {
  @override
  _TopBarModState createState() => _TopBarModState();
}

class _TopBarModState extends State<TopBarMod> {
  var type;
  var name;
  @override
  initState() {
    fetchUsertype();
    fetchUserName();
    super.initState();
  }

  fetchUsertype() async {
    dynamic result = await context.read<Authenticate>().retrieveUsertype();
    if (result == null) {
      print('Unable ro retrieve data');
    } else {
      if (mounted) {
        setState(() {
          type = result;
          print('usertype: $type');
        });
      }
    }
  }

  fetchUserName() async {
    dynamic result = await context.read<Authenticate>().retrieveName();
    if (result == null) {
      print("Unable to retrieve user's name");
    } else {
      if (mounted) {
        setState(() {
          name = result;
          print("user's: $name");
        });
      }
    }
  }

  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          flex: 5,
          child: Row(children: <Widget>[
            Container(
                child: ElevatedButton(
              onPressed: () async {
                if (type == "Commuter") {
                  return showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Restricted Feature'),
                          content: Text('For drivers only'),
                          actions: <Widget>[
                            ElevatedButton(
                                child: Text("CLOSE"),
                                onPressed: () {
                                  Navigator.pop(context);
                                })
                          ],
                        );
                      });
                }
                if (MyApp.inboard == false) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Onboard()));
                  MyApp.inboard = true;
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LocationSelection()));
                  MyApp.inboard = false;
                }

                if (MyApp.ping == true) {
                  showDialog(
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
                      });
                }
              },
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: Colors.yellow[700],
              ),
              child: toOnboard(),
            )),
          ])),
      Expanded(
          child: InkWell(
              onTap: () {
                if (MyApp.ping == true) {
                  showDialog(
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
                      });
                }
                Navigator.pop(context);
              },
              child: Image.asset('assets/icons8-reply-arrow-30.png')))
    ]);
  }

  toOnboard() {
    if (MyApp.inboard == false) {
      return Text('Onboard', style: TextStyle(fontWeight: FontWeight.bold));
    } else {
      return Text('Selection', style: TextStyle(fontWeight: FontWeight.bold));
    }
  }
}

mixin authenticate {}

TextSpan alleyCheck() {
  if (MyApp.alley) {
    return TextSpan(
        text: "Alley",
        style:
            TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold));
  } else {
    return TextSpan(
        text: "Riding",
        style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold));
  }
}
