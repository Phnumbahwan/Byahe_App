import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/topbarmod.dart';

class LocationSelection extends StatefulWidget {
  // const LocationSelection({ Key? key }) : super(key: key);

  @override
  _LocationSelectionState createState() => _LocationSelectionState();
}

class _LocationSelectionState extends State<LocationSelection> {
  // ignore: missing_return
  Widget locationStatusLayout(String status) {
    switch (status) {
      case "LOW":
        {
          return Text(
            "• LOW",
            style: TextStyle(color: Colors.yellow[400]),
          );
        }
        break;

      case "MEDIUM":
        {
          return Text(
            "• MEDIUM",
            style: TextStyle(color: Colors.green[400]),
          );
        }
        break;

      case "HIGH":
        {
          return Text(
            "• HIGH",
            style: TextStyle(color: Colors.red[400]),
          );
        }
        break;
    }
  }

  var locationStatus = [
    {'location': 'Gusa', 'status': 'HIGH'},
    {'location': 'Cugman', 'status': 'LOW'},
    {'location': 'Lapasan', 'status': 'MEDIUM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      child: Column(
        children: <Widget>[
          Container(height: 50, child: TopBarMod()),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              child: TextFormField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: ('Search here ...'),
                    border: OutlineInputBorder()),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
                children: locationStatus
                    .map((location) => Container(
                        color: Colors.yellow[700],
                        padding: EdgeInsets.all(20),
                        child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/routeselection');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Text(location['location'],
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Container(
                                  child:
                                      locationStatusLayout(location['status']),
                                )
                              ],
                            ))))
                    .toList()),
          )
        ],
      ),
    )));
  }
}
