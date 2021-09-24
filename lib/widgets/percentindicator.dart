import 'package:flutter/material.dart';

class PercentIndicator extends StatelessWidget {
  final int status;

  PercentIndicator(this.status);

  Color turnGreen(pos) {
    print(status);
    if (status >= pos) {
      if (status <= 2) {
        return Colors.green;
      } else if (status == 3) {
        return Colors.yellow;
      } else if (status >= 4) {
        return Colors.red;
      }
    } else {
      return Colors.white;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
        margin: EdgeInsets.symmetric(horizontal: 1),
        child: CircleAvatar(
          backgroundColor: turnGreen(1),
          radius: 5,
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 1),
        child: CircleAvatar(
          backgroundColor: turnGreen(2),
          radius: 5,
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 1),
        child: CircleAvatar(
          backgroundColor: turnGreen(3),
          radius: 5,
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 1),
        child: CircleAvatar(
          backgroundColor: turnGreen(4),
          radius: 5,
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 1),
        child: CircleAvatar(
          backgroundColor: turnGreen(5),
          radius: 5,
        ),
      )
    ]);
  }
}
