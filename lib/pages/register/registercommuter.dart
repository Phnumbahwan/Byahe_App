import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/closebutton.dart';

class RegisterCommuter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        children: <Widget>[
          SafeArea(
            child: CloseButtonBlack(),
          ),
          Text(
            'BYAHE',
            style: TextStyle(
              fontFamily: 'Thasadith',
              fontWeight: FontWeight.bold,
              color: Colors.yellow[700],
              fontSize: 60,
            ),
          ),
          Image.asset('assets/undraw_town_r6pc__1_-removebg-preview.png'),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          fixedSize: Size(300, 50),
                          shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Colors.yellow, width: 0.1),
                              borderRadius: BorderRadius.circular(20))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/google.png',
                                  width: 30,
                                )),
                            RichText(
                              text: TextSpan(
                                  text: "Register using ",
                                  style: TextStyle(color: Colors.black),
                                  children: const <TextSpan>[
                                    TextSpan(
                                        text: "Google",
                                        style:
                                            TextStyle(color: Colors.redAccent)),
                                    TextSpan(text: " Account")
                                  ]),
                            )
                          ]))),
              Container(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          fixedSize: Size(300, 50),
                          shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Colors.yellow, width: 0.1),
                              borderRadius: BorderRadius.circular(20))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/facebook.png',
                                  width: 30,
                                )),
                            RichText(
                              text: TextSpan(
                                  text: "Register using ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13),
                                  children: const <TextSpan>[
                                    TextSpan(
                                        text: "Facebook",
                                        style: TextStyle(
                                            color: Colors.blueAccent)),
                                    TextSpan(text: " Account")
                                  ]),
                            )
                          ])))
            ],
          )
        ],
      ),
    )));
  }
}
