import 'dart:ui';

import 'package:byahe_app/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/topbarmod.dart';
import 'package:byahe_app/widgets/driver/navigationalcontainer.dart';

class Reserve extends StatefulWidget {
  // const Reserve({ Key? key }) : super(key: key);

  @override
  _ReserveState createState() => _ReserveState();
}

class _ReserveState extends State<Reserve> {
  String pageName = 'Reserve';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
                    child: Column(children: <Widget>[
      Container(height: 50, child: TopBarMod()),
      Container(
        child: Text(
          this.pageName.toUpperCase(),
          style: TextStyle(color: Colors.yellowAccent[700], fontSize: 30),
        ),
      ),
      NavigationalContainer(this.pageName),
      Container(
        child: Column(
            children: reserve
                .map((info) => Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(width: 2, color: Colors.yellow[700]),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.grey,
                              offset: Offset(3, 3)),
                        ]),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      AssetImage('assets/salac.jpg'),
                                )),
                            Container(
                              child: Text(
                                info['firstname'] +
                                    ' ' +
                                    info['lastname'] +
                                    ', ' +
                                    info['desired_reserve_date'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                            Container(
                                child: Row(children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: Image.asset(
                                  'assets/check.png',
                                  width: 35,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: Image.asset(
                                  'assets/reject.png',
                                  width: 35,
                                ),
                              )
                            ]))
                          ]),
                      Container(
                          alignment: Alignment.bottomCenter,
                          child: Text('Tap to view details',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 10)))
                    ])))
                .toList()),
      )
    ])))));
  }
}
