import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class drawer extends StatefulWidget {
  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: new ListView(
          children: <Widget>[
            //    header
            new UserAccountsDrawerHeader( 
                decoration: BoxDecoration(
                    color: Colors.pink,
                ),
                accountName: Text('Ian Salac'),
                accountEmail: Text('salacian@gmail.com')),
            RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.grey, fontSize: 20.0),
                  children: [
                    TextSpan(
                        text: 'Log Out',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/');
                          })
                  ]),
            ),
          ],
        ),
    );
  }
}
