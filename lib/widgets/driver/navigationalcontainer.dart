import 'package:byahe_app/pages/driver/onboard.dart';
import 'package:byahe_app/pages/driver/pending.dart';
import 'package:byahe_app/pages/driver/reserve.dart';
import 'package:byahe_app/pages/driver/setup-alley.dart';
import 'package:flutter/material.dart';

class NavigationalContainer extends StatefulWidget {
  // const NavigationalContainer({ Key? key }) : super(key: key);
  String pageName;
  NavigationalContainer(this.pageName);

  @override
  _NavigationalContainerState createState() =>
      _NavigationalContainerState(this.pageName);
}

class _NavigationalContainerState extends State<NavigationalContainer> {
  String pageName;
  _NavigationalContainerState(this.pageName);

  // ignore: missing_return
  Color setColor(String nav) {
    if (nav == this.pageName) {
      return Colors.yellow[700];
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/undraw_by_my_car_ttge-removebg-preview (1).png"),
                fit: BoxFit.cover)),
        child: Container(
          child: Column(children: <Widget>[
            Container(
              height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.white),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.grey,
                              offset: Offset(3, 3)),
                        ]),
                    height: 80,
                    width: 80,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Onboard()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            'assets/undraw_Setup_wizard_re_nday-removebg-preview.png',
                            fit: BoxFit.fill,
                          ),
                          Text(
                            'Onboard',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: setColor('Onboard')),
                          )
                        ],
                      ),
                    )),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.white),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Colors.grey,
                            offset: Offset(3, 3)),
                      ]),
                  height: 80,
                  width: 80,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Pending()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          'assets/undraw_pending_approval_xuu9-removebg-preview.png',
                          fit: BoxFit.fill,
                        ),
                        Text(
                          'Pending',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: setColor('Pending')),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.white),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.grey,
                              offset: Offset(3, 3)),
                        ]),
                    height: 80,
                    width: 80,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SetupAlley()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            'assets/undraw_by_my_car_ttge-removebg-preview.png',
                            fit: BoxFit.fill,
                          ),
                          Text(
                            'Set-up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: setColor('Set-up')),
                          )
                        ],
                      ),
                    )),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.white),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.grey,
                              offset: Offset(3, 3)),
                        ]),
                    height: 80,
                    width: 80,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Reserve()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            'assets/undraw_Booking_re_gw4j-removebg-preview.png',
                            fit: BoxFit.fill,
                          ),
                          Text(
                            'Booking',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: setColor('Booking')),
                          )
                        ],
                      ),
                    ))
              ],
            )
          ]),
        ));
  }
}
