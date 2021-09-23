import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  // const LoginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Text(
            'BYAHE',
            style: TextStyle(
              fontFamily: 'Thasadith',
              fontWeight: FontWeight.bold,
              color: Colors.yellow[700],
              fontSize: 60,
            ),
          )),
          Image.asset('assets/undraw_Vehicle_sale_a645-removebg-preview.png'),
          Form(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: ("Username"),
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder()),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: ("Password"),
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder()),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/locationselection');
                      },
                      child: Text("LOGIN"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.yellow[700],
                          fixedSize: Size(200, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                    )),
                Text("Don't have account yet? Register now!",
                    style: TextStyle(fontSize: 10, color: Colors.blue[200]))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
