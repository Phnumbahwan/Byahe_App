import 'package:byahe_app/main.dart';
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
            Container(
                child: Text(
              'ID : 2018101451',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            Container(
                child: true
                    ? RichText(
                        text: TextSpan(
                            text: "   Status: ",
                            style: TextStyle(color: Colors.black, fontSize: 13),
                            children: <TextSpan>[
                              alleyCheck(),
                            ]),
                      )
                    : null)
          ])),
      Expanded(
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/icons8-reply-arrow-30.png')))
    ]);
  }
}

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
