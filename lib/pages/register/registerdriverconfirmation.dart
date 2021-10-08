import 'package:byahe_app/widgets/closebutton.dart';
import 'package:flutter/material.dart';

class RegisterDriverConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          SafeArea(
            child: CloseButtonBlack(),
          ),
          Container(
              margin: EdgeInsets.only(top: 50),
              child: Image.asset(
                  'assets/undraw_towing_6yy4-removebg-preview.png')),
          Container(
            child: Text(
              "Please screenshot or copy this confirmation code. For you to confirm us of your identity.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.yellow[700], fontSize: 15),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "CONFIRMATION CODE : ",
              style: TextStyle(
                  color: Colors.yellow[700], fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
            color: Colors.yellow[50],
            child: Text(
              "QDE34D",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.yellow[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          )
        ],
      ),
    )));
  }
}
