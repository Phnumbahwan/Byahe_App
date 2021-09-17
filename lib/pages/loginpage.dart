import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  // const LoginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Text(
            'BYAHE',
            style: TextStyle(
              fontFamily: 'Thasadith',
              color: Colors.yellow,
              fontSize: 60,
            ),
          )),
          SvgPicture.asset('assets/undraw_Vehicle_sale_a645.svg'),
        ],
      ),
    ));
  }
}
