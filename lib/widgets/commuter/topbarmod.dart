import 'package:byahe_app/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TopBarMod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          flex: 5,
          child: Row(children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('assets/salac.jpg'),
                )),
            Container(height: 50, child: drawer()),
            Container(
                child: Text(
              'ID : 2018101451',
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
          ])),
      Expanded(
          child: InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
                //Navigator.pop(context);
              },
              //child: Image.asset('assets/icons8-reply-arrow-30.png')))
              child: Text('log out')))
    ]);
  }
}
