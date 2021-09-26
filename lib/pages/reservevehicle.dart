import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/widgets/topbarmod.dart';
import 'package:byahe_app/data/data.dart';

class ReserveVehicle extends StatefulWidget {
  // const ReserveVehicle({ Key? key }) : super(key: key);

  @override
  _ReserveVehicleState createState() => _ReserveVehicleState();
}

class _ReserveVehicleState extends State<ReserveVehicle> {
  TextEditingController dateCtl = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
      child: Column(children: <Widget>[
        Container(height: 50, child: TopBarMod()),
        Container(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("RESERVE/BOOKING",
                  style: TextStyle(color: Colors.yellow[700])),
            )),
        Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.yellow[700]))),
            padding: EdgeInsets.all(20),
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text("Route-RD",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow[800])),
              ),
              Container(
                child: Row(children: <Widget>[
                  Text("Driver's name : "),
                  Text("${driverInfo[1]['driver_name']}")
                ]),
              ),
              Container(
                child: Row(children: <Widget>[
                  Text("Address : "),
                  Text("${driverInfo[1]['address']}")
                ]),
              ),
              Container(
                child: Row(children: <Widget>[
                  Text("License number : "),
                  Text("${driverInfo[1]['license_number']}")
                ]),
              ),
              Container(
                child: Row(children: <Widget>[
                  Text("Vehicle Plate Number : "),
                  Text("${driverInfo[1]['vehicle_plate_number']}")
                ]),
              ),
              Container(
                child: Row(children: <Widget>[
                  Text("Contact Number : "),
                  Text("${driverInfo[1]['contact_number']}")
                ]),
              ),
            ])),
        Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.yellow[700]))),
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              child: Column(children: <Widget>[
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.yellow[700])),
                          labelText: 'Last name',
                          border: OutlineInputBorder()),
                    )),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.yellow[700])),
                          labelText: "First name",
                          border: OutlineInputBorder()),
                    )),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.yellow[700])),
                          labelText: "Gender",
                          border: OutlineInputBorder()),
                    )),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.yellow[700])),
                          labelText: "Address",
                          border: OutlineInputBorder()),
                    )),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.yellow[700])),
                          labelText: "Contact number",
                          border: OutlineInputBorder()),
                    )),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.yellow[700])),
                          labelText: "Number of Passengers",
                          border: OutlineInputBorder()),
                    )),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: dateCtl,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.calendar_today_sharp),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow[700])),
                        border: OutlineInputBorder(),
                        labelText: "Desired Reservation Date",
                      ),
                      onTap: () async {
                        DateTime date = DateTime(1900);
                        FocusScope.of(context).requestFocus(new FocusNode());

                        date = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));

                        if (date != null) {
                          setState(() {
                            selectedDate = date;
                          });
                        }
                        dateCtl.text = date.toIso8601String().split('T')[0];
                      },
                    )),
              ]),
            )),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.yellow[700], minimumSize: Size(200, 50)),
              onPressed: () {},
              child: Text("CONFIRM")),
        )
      ]),
    ))));
  }
}
