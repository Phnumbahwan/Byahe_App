import 'package:byahe_app/pages/commuter/routeselection.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/topbarmod.dart';

class LocationSelection extends StatefulWidget {
  // const LocationSelection({ Key? key }) : super(key: key);

  @override
  _LocationSelectionState createState() => _LocationSelectionState();
}

class _LocationSelectionState extends State<LocationSelection> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

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
        body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
      child: Column(
        children: <Widget>[
          Container(height: 50, child: TopBarMod()), //MAIN TOP BAR
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              child: TextFormField(
                controller: myController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[700])),
                    suffixIcon: InkWell(
                        child: Icon(
                      Icons.search,
                      color: Colors.yellow[700],
                    )),
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
                              // Navigator.pushNamed(context, '/routeselection');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RouteSelection()));
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
    ))));
  }
}
