import 'package:byahe_app/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/topbarmod.dart';
import 'package:byahe_app/widgets/driver/navigationalcontainer.dart';
import 'package:flutter/painting.dart';

class Pending extends StatefulWidget {
  // const Pending({ Key? key }) : super(key: key);

  @override
  _PendingState createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  String pageName = 'Pending';
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
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: RichText(
            text: TextSpan(
                text: "Total Pending :",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: pending.length.toString(),
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold)),
                ]),
          )),
      Container(
          child: Column(
        children: pending
            .map((commuter) => Container(
                decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.grey,
                          offset: Offset(3, 3)),
                    ]),
                padding: EdgeInsets.symmetric(vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundImage: AssetImage('assets/salac.jpg'),
                            )),
                        Container(
                          child: Text(
                            'ID: ' + commuter['commuter_id'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ]),
                      Row(children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Image.asset(
                            'assets/check.png',
                            width: 50,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Image.asset(
                            'assets/reject.png',
                            width: 50,
                          ),
                        )
                      ])
                    ])))
            .toList(),
      ))
    ])))));
  }
}
