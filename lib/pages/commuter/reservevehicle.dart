import 'package:byahe_app/pages/login_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:byahe_app/widgets/drawer/drawerheader.dart';
import 'package:byahe_app/widgets/drawer/drawerlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:byahe_app/widgets/topbarmod.dart';
//import 'package:byahe_app/data/data.dart';
import 'package:provider/src/provider.dart';

// ignore: must_be_immutable
class ReserveVehicle extends StatefulWidget {
  // const ReserveVehicle({ Key? key }) : super(key: key);
  var routeData;
  ReserveVehicle(this.routeData);

  @override
  _ReserveVehicleState createState() => _ReserveVehicleState(this.routeData);
}

class _ReserveVehicleState extends State<ReserveVehicle> {
  var routeData;
  _ReserveVehicleState(this.routeData);
  TextEditingController fnameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController numpassController = TextEditingController();
  TextEditingController dateCtlController = TextEditingController();
  String useruid = FirebaseAuth.instance.currentUser.uid;
  var timenow = Timestamp.now();
  var commuterName;
  DateTime selectedDate = DateTime.now();
  List category = [
    {'purpose': 'Special Occasions'},
    {'purpose': 'Strike'}
  ];
  List genders = [
    {'gender': 'Male'},
    {'gender': 'Female'}
  ];
  var selectedPurpose = 'none';
  var selectedGender = 'none';

  @override
  void initState() {
    super.initState();
    fetchCommuterName();
  }

  fetchCommuterName() async {
    dynamic result = await context.read<Authenticate>().retrieveName();
    if (result == null) {
      print('Unable to retrieve commuter name (reservedetails.dart');
    } else {
      if (mounted) {
        setState(() {
          commuterName = result;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            bottomOpacity: 0.0,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.yellow[700]),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            title: Text('Byahe App',
                style: TextStyle(
                    color: Colors.yellow[700], fontWeight: FontWeight.bold))),
        drawer: Drawer(
            child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [DrawerHead(), DrawerList()],
            ),
          ),
        )),
        body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
          child: Column(children: <Widget>[
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
                    child: Text(routeData['route_path'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow[800])),
                  ),
                  Container(
                    child: Row(children: <Widget>[
                      Text("Driver's name : "),
                      Text(routeData['first_name'] +
                          " " +
                          routeData['last_name'])
                    ]),
                  ),
                  Container(
                    child: Row(children: <Widget>[
                      Text("Jeepney Line : "),
                      Text(routeData['jeepney_line'])
                    ]),
                  ),
                  /*Container(
                child: Row(children: <Widget>[
                  Text("License number : "),
                  Text("${driverInfo[1]['license_number']}")
                ]),
              ),*/
                  Container(
                    child: Row(children: <Widget>[
                      Text("Vehicle Plate Number : "),
                      Text(routeData['vehicle_plate_number'])
                    ]),
                  ),
                  Container(
                    child: Row(children: <Widget>[
                      Text("Contact Number : "),
                      Text(routeData['mobile_number'].toString())
                    ]),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text('Note: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Not for individual reservation but a group"),
                      ],
                    ),
                  )
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
                          textCapitalization: TextCapitalization.words,
                          //initialValue: commuterName,
                          enabled: false,
                          controller: fnameController =
                              new TextEditingController(text: commuterName),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.yellow[700])),
                              labelText: 'Fullname',
                              border: OutlineInputBorder()),
                        )),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: DropdownButtonFormField(
                          isExpanded: true,
                          items: genders
                              .map((chosen) => new DropdownMenuItem<String>(
                                  value: chosen['gender'],
                                  child: Text(
                                    chosen['gender'],
                                    overflow: TextOverflow.ellipsis,
                                  )))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow[700]),
                            ),
                            //borderRadius: BorderRadius.circular(17)),
                            labelText: "Gender",
                            border: OutlineInputBorder(),
                          )),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.words,
                          controller: addressController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.yellow[700])),
                              labelText: "Pick-up Address",
                              border: OutlineInputBorder()),
                        )),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          //validator: ,
                          maxLength: 11,
                          keyboardType: TextInputType.number,
                          controller: numberController,
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
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          controller: numpassController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.yellow[700])),
                              labelText: "Number of Passengers",
                              border: OutlineInputBorder()),
                        )),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: DropdownButtonFormField(
                          isExpanded: true,
                          items: category
                              .map((choice) => new DropdownMenuItem<String>(
                                  value: choice['purpose'],
                                  child: Text(
                                    choice['purpose'],
                                    overflow: TextOverflow.ellipsis,
                                  )))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedPurpose = value;
                            });
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow[700]),
                            ),
                            //borderRadius: BorderRadius.circular(17)),
                            labelText: "Purpose",
                            border: OutlineInputBorder(),
                          )),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: dateCtlController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.calendar_today_sharp),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.yellow[700])),
                            border: OutlineInputBorder(),
                            labelText: "Desired Reservation Date",
                          ),
                          onTap: () async {
                            DateTime date = DateTime(1900);
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());

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
                            dateCtlController.text =
                                date.toIso8601String().split('T')[0];
                          },
                        )),
                  ]),
                )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.yellow[700], minimumSize: Size(200, 50)),
                  onPressed: () {
                    var fname = fnameController.text.trim();
                    //var gender = genderController.text.trim();
                    var address = addressController.text.trim();
                    var number = numberController.text.trim();
                    var numpass = numpassController.text.trim();
                    var date = dateCtlController.text.trim();

                    if (int.parse(numpass) < 3) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  "This is not intended for individual booking!"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('CLOSE'),
                                )
                              ],
                            );
                          });
                    }

                    if (fname.isEmpty ||
                        selectedGender == 'none' ||
                        //gender.isEmpty |
                        address.isEmpty | number.isEmpty | numpass.isEmpty ||
                        selectedPurpose == 'none' ||
                        date.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Complete the fields to proceed"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('CLOSE'),
                                )
                              ],
                            );
                          });
                    } else /*if (!(fname.isEmpty |
                        gender.isEmpty |
                        address.isEmpty |
                        number.isEmpty |
                        numpass.isEmpty |
                        date.isEmpty)) */
                    {
                      try {
                        var vehicle_plate;
                        var drivername;
                        var fnamePlate;
                        var fnameTime;
                        drivername = routeData['last_name'];
                        vehicle_plate = routeData['vehicle_plate_number'];
                        fnamePlate = (fname + vehicle_plate).trim();
                        fnameTime = (fname + timenow.toString()).trim();
                        var status = 'Pending';
                        context
                            .read<Authenticate>()
                            .bookings()
                            .then((value) async {
                          User user = FirebaseAuth.instance.currentUser;
                          await FirebaseFirestore.instance
                              .collection('bookings')
                              .doc(fnameTime /*fnamePlate*/)
                              .set({
                            'date_applied': timenow, //Timestamp.now(),
                            'applicant_reference': useruid,
                            'status': status,
                            'plate_reference': vehicle_plate,
                            'driver_name': drivername,
                            "customer_name": fname,
                            'gender': selectedGender,
                            'address': address,
                            'contact_number': int.parse(number),
                            'number_of_passengers': int.parse(numpass),
                            'purpose': selectedPurpose,
                            'date_to_reserve': date,
                          });
                        });
                        fnameController.clear();
                        genderController.clear();
                        numberController.clear();
                        numpassController.clear();
                        dateCtlController.clear();
                        addressController.clear();
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Booking Request Submitted"),
                                content: Text("Wait for the driver's response"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: Text('CLOSE'),
                                  )
                                ],
                              );
                            });
                      } catch (e) {
                        return showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                actionsOverflowDirection:
                                    VerticalDirection.down,
                                title: Text(e.toString()),
                                actions: <Widget>[
                                  ElevatedButton(
                                      child: Text("CLOSE"),
                                      onPressed: () {
                                        /*context
                                        .read<Authenticate>()
                                        .login(email, password);*/
                                        Navigator.of(context).pop();
                                      })
                                ],
                              );
                            });
                      }
                    }
                  },
                  child: Text("CONFIRM")),
            )
          ]),
        ))));
  }
}
