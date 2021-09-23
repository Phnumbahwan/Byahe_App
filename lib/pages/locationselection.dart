import 'package:flutter/material.dart';

class LocationSelection extends StatefulWidget {
  // const LocationSelection({ Key? key }) : super(key: key);

  @override
  _LocationSelectionState createState() => _LocationSelectionState();
}

class _LocationSelectionState extends State<LocationSelection> {

  var locationStatus = [
    {'location': 'Gusa', 'status': '1'},
    {'location': 'Cugman', 'status': '2'},
    {'location': 'Lapasan', 'status': '5'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: CircleAvatar(
                  backgroundImage: AssetImage('assets/salac.jpg'),
                )),
                Expanded(flex: 4, child: Text('ID : 2018101451')),
                Expanded(child: Image.asset('assets/icons8-reply-arrow-30.png'))
              ],
            ),
          ),
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
            child: Column(
              children: locationStatus.map((location) => 
                Row(
                  children: <Widget>[
                    
                  ],
                )
              ).toList()
            ),
          )
        ],
      ),
    )));
  }
}
