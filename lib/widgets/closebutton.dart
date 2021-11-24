import 'package:byahe_app/pages/login/loginpage.dart';
import 'package:flutter/material.dart';

class CloseButtonBlack extends StatelessWidget {
  // const CloseButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 30,
      child: InkWell(
          onTap: () {
            // Navigator.pushNamed(context, '/loginpage');
            Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginPage()));
          },
          child: Image.asset('assets/closeblack.png')),
    );
  }
}
