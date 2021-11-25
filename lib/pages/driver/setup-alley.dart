import 'package:byahe_app/data/data.dart';
import 'package:byahe_app/main.dart';
import 'package:byahe_app/pages/driver/setup-check.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/topbarmod.dart';
import 'package:byahe_app/widgets/driver/navigationalcontainer.dart';

class SetupAlley extends StatefulWidget {
  // const SetupAlley({ Key? key }) : super(key: key);

  @override
  _SetupAlleyState createState() => _SetupAlleyState();
}

class _SetupAlleyState extends State<SetupAlley> {
  String pageName = 'Set-up';
  String groupname = 'MODA JEEP ORG';
  String myPlatenumber = 'KMJS 000';

  Container alleyFunction() {
    if (MyApp.alley == false) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: Colors.yellow[700]),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Text('ALLEY NOW !', style: TextStyle(color: Colors.yellow[700])),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: Colors.redAccent),
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Text('CANCEL NOW !', style: TextStyle(color: Colors.white)),
      );
    }
  }

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                width: 180,
                height: 70,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SetupAlley()));
                    },
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Colors.yellow[700],
                    ),
                    child: Text("Alley",
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                width: 180,
                height: 70,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SetupCheck()));
                    },
                    style: ElevatedButton.styleFrom(
                        onPrimary: Colors.yellow[700], primary: Colors.white),
                    child: Text("Check drivers",
                        style: TextStyle(fontWeight: FontWeight.bold))))
          ],
        ),
      ),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'assets/add-group.png',
                        width: 30,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(this.groupname,
                          style: TextStyle(color: Colors.yellow[700])),
                    )
                  ],
                ),
                InkWell(
                    onTap: () {
                      if (MyApp.alley == true) {
                        for (var map in alleyDrivers) {
                          if (map['vehicle_plate_number'] ==
                              this.myPlatenumber) {
                            alleyDrivers.remove(map);
                            break;
                          }
                        }
                      } else {
                        alleyDrivers
                            .add({'vehicle_plate_number': this.myPlatenumber});
                      }
                      setState(() {
                        MyApp.alley = !MyApp.alley;
                      });
                    },
                    child: alleyFunction())
              ])),
      Container(
        child: Column(
            children: alleyDrivers
                .map((jeep) => Container(
                    decoration: BoxDecoration(
                        color:
                            this.myPlatenumber == jeep['vehicle_plate_number']
                                ? Colors.yellowAccent[700]
                                : Colors.yellow[700],
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.grey,
                              offset: Offset(3, 3)),
                        ]),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(children: <Widget>[
                            Container(
                              child: Text(
                                (alleyDrivers.indexOf(jeep) + 1).toString() +
                                    '. ' +
                                    jeep['vehicle_plate_number'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ]),
                          Container(
                            child: Icon(Icons.more_horiz),
                          )
                        ])))
                .toList()),
      )
    ])))));
  }
}
