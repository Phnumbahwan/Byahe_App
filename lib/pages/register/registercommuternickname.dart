import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/closebutton.dart';

class RegisterCommuterNickname extends StatelessWidget {
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
          Image.asset('assets/undraw_off_road_9oae-removebg-preview.png'),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                            color: Colors.yellow[700],
                            fontFamily: 'DancingScript',
                            fontSize: 25),
                      )),
                  Text("what do you want us to call you?",
                      style: TextStyle(fontSize: 15, color: Colors.yellow[700]))
                ],
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
            child: Form(
              child: TextFormField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                    focusColor: Colors.yellow,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.yellow[800], width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    filled: true,
                    fillColor: Colors.yellow[50],
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.yellow[800])),
                    suffixIcon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.yellow[800],
                    ),
                    hintText: ('-- Insert nickname here --'),
                    hintStyle: TextStyle(color: Colors.yellow[200]),
                    border: OutlineInputBorder()),
              ),
            ),
          ),
        ],
      ),
    )));
  }
}
