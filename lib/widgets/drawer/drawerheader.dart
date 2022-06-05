import 'package:byahe_app/pages/login_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class DrawerHead extends StatefulWidget {
  // const DrawerHeader({ Key? key }) : super(key: key);

  @override
  _DrawerHeadState createState() => _DrawerHeadState();
}

class _DrawerHeadState extends State<DrawerHead> {
  var email;
  var name;
  @override
  initState() {
    super.initState();
    fetchEmail();
    fetchName();
  }

  fetchEmail() async {
    dynamic result = await context.read<Authenticate>().getEmail();

    if (result == null) {
      print('Unable to retrieve email (drawerheader.dart)');
    } else {
      setState(() {
        email = result;
      });
    }
  }

  fetchName() async {
    dynamic result = await context.read<Authenticate>().retrieveName();
    if (result == null) {
      print('Unable to retrieve name (drawerheader.dart)');
    } else {
      setState(() {
        name = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.yellow[700],
      ),
      child: Column(
        children: [
          SizedBox(height: 100),
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: (name != null)
                ? Text(name, style: TextStyle(color: Colors.white))
                : Text('Anonymous', style: TextStyle(color: Colors.white)),
            subtitle: (email != null)
                ? Text(email, style: TextStyle(color: Colors.white))
                : Text('anonymous@email.com',
                    style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
