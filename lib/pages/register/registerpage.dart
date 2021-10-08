import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/closebutton.dart';

class RegisterPage extends StatelessWidget {
  // const RegisterPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
          Image.asset('assets/undraw_sculpting_1c9p-removebg-preview.png'),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registercommuter');
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.yellow[700],
                    fixedSize: Size(250, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Are you a", style: TextStyle(fontSize: 15)),
                      Text("COMMUTER?", style: TextStyle(fontSize: 20))
                    ])),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registerdriver');
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.yellow[700],
                    fixedSize: Size(250, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Are you a", style: TextStyle(fontSize: 15)),
                      Text("DRIVER?", style: TextStyle(fontSize: 20))
                    ])),
          )
        ],
      ),
    )));
  }
}
