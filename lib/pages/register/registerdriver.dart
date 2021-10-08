import 'package:byahe_app/widgets/closebutton.dart';
import 'package:flutter/material.dart';

class RegisterDriver extends StatefulWidget {
  @override
  _RegisterDriverState createState() => _RegisterDriverState();
}

class _RegisterDriverState extends State<RegisterDriver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
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
          Image.asset('assets/undraw_navigator_a479-removebg-preview.png'),
          Container(
              child: Text(
            "Please fillup this pre-registration form. And get a copy of your confirmation code. After that wait for our team to contact you and settle for an appointment",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17),
          )),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[700]),
                        borderRadius: BorderRadius.circular(17)),
                    labelText: "Last name",
                    border: OutlineInputBorder()),
              )),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[700]),
                        borderRadius: BorderRadius.circular(17)),
                    labelText: "First name",
                    border: OutlineInputBorder()),
              )),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[700]),
                        borderRadius: BorderRadius.circular(17)),
                    labelText: "Address",
                    border: OutlineInputBorder()),
              )),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[700]),
                        borderRadius: BorderRadius.circular(17)),
                    labelText: "Mobile number",
                    border: OutlineInputBorder()),
              )),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 30),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/registerdriverconfirmation');
              },
              child: Text("CONFIRM"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.yellow[700],
                  fixedSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          )
        ],
      ),
    )));
  }
}
