import 'package:flutter/material.dart';

class AccountNumber extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 5,
        child: Row(children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage('assets/salac.jpg'),
              )),
          Container(child: Text('ID : 2018101451'))
        ]));
  }
}
