import 'package:byahe_app/widgets/drawer/drawerheader.dart';
import 'package:byahe_app/widgets/drawer/drawerlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:byahe_app/pages/login_auth.dart';
import 'package:intl/intl.dart';
import '../login_auth.dart';

class ReserveDetails extends StatefulWidget {
  @override
  _ReserveDetailsState createState() => _ReserveDetailsState();
}

class _ReserveDetailsState extends State<ReserveDetails> {
  var bookingDetails = [];
  Stream<QuerySnapshot> bookings;
  String useruid = FirebaseAuth.instance.currentUser.uid;
  var name;
  var fnamePlate;
  bool isButtonDisabled = false;

  @override
  initState() {
    super.initState();
    fetchCommuterName();
    fetchBookingDetails();
  }

  fetchCommuterName() async {
    dynamic result = await context.read<Authenticate>().retrieveName();
    if (result == null) {
      print('Unable to retrieve commuter name (reservedetails.dart');
    } else {
      if (mounted) {
        setState(() {
          name = result;
        });
      }
    }
  }

  fetchBookingDetails() async {
    dynamic result = await context.read<Authenticate>().displayBookings();
    if (result == null) {
      print('Unable to retrieve booking details (reserverdetails.dart)');
    } else {
      if (mounted) {
        setState(() {
          bookingDetails = result;
        });
      }
    }
  }

  fetchBookings(commuter_name) {
    Stream<QuerySnapshot> bookings = FirebaseFirestore.instance
        .collection('bookings')
        .where('customer_name', isEqualTo: commuter_name)
        .snapshots();
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
                child: Text("YOUR RESERVE/BOOKING",
                    style: TextStyle(color: Colors.yellow[700])),
              )),
          Container(
              child: StreamBuilder(
                  stream: bookings = FirebaseFirestore.instance
                      .collection('bookings')
                      .where('applicant_reference', isEqualTo: useruid)
                      .orderBy('date_applied', descending: false)
                      //.where('customer_name', isEqualTo: name)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Container(
                          child:
                              Center(child: Text('Failed to Retreive Info')));
                    }
                    if (snapshot.hasData == false) {
                      return Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Center(child: CircularProgressIndicator()));
                    }
                    return Column(
                        children: snapshot.data.docs //bookingDetails
                            .map((info) => InkWell(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        border: Border.all(
                                            width: 2,
                                            color: Colors.yellow[700]),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 10,
                                              color: Colors.grey,
                                              offset: Offset(3, 3)),
                                        ]),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Column(children: <Widget>[
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Text(
                                                  "Status: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                (info['status'] != "Cancelled")
                                                    ? Text(
                                                        info['status'] != null
                                                            ? info['status']
                                                            : 'Loading...',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                            color:
                                                                Colors.yellow))
                                                    : Text(
                                                        info['status'] != null
                                                            ? info['status']
                                                            : 'Loading...',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                            color: Colors.red)),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Date Booked: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                    info['date_applied'] != null
                                                        ? DateFormat(
                                                                'yyyy-MM-dd – kk:mm')
                                                            .format(info[
                                                                    'date_applied']
                                                                .toDate())
                                                            .toString()
                                                        : '...',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Driver Name: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                    info['driver_name'] != null
                                                        ? info['driver_name']
                                                        : '...',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Jeepney Plate No: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                    info['plate_reference'] !=
                                                            null
                                                        ? info[
                                                            'plate_reference']
                                                        : '...',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Customer's Name: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                    info['customer_name'] !=
                                                            null
                                                        ? info['customer_name']
                                                        : '...',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Gender: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                    info['gender'] != null
                                                        ? info['gender']
                                                        : '...',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Specified No. of Passengers: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                    info['number_of_passengers']
                                                                .toString() !=
                                                            null
                                                        ? info['number_of_passengers']
                                                            .toString()
                                                        : '...',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Contact No: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                    info['contact_number']
                                                                .toString() !=
                                                            null
                                                        ? info['contact_number']
                                                            .toString()
                                                        : '...',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Customer Address: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                    info['address'] != null
                                                        ? info['address']
                                                        : '...',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Booking Purpose: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                    info['purpose'] != null
                                                        ? info['purpose']
                                                        : '...',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Date of Reservation: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                    info['date_to_reserve'] !=
                                                            null
                                                        ? info[
                                                            'date_to_reserve']
                                                        : '...',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                            (info['status'] != "Cancelled")
                                                ? Container(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Colors
                                                                        .yellow[
                                                                    700],
                                                                minimumSize:
                                                                    Size(80,
                                                                        35)),
                                                        onPressed: () {
                                                          var response;
                                                          response =
                                                              "Cancelled";
                                                          if (info['status'] !=
                                                              "Cancelled") {
                                                            setState(() {
                                                              //isButtonDisabled = true;
                                                              context
                                                                  .read<
                                                                      Authenticate>()
                                                                  .respondBooking(
                                                                      fnamePlate = info[
                                                                              'customer_name'] +
                                                                          info['date_applied']
                                                                              .toString(),
                                                                      //info['plate_reference'],
                                                                      response);
                                                            });
                                                          }
                                                        },
                                                        child: Text(
                                                            'Cancel Request')),
                                                  )
                                                : Container(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text('CANCELLED',
                                                        style: TextStyle(
                                                            color: Colors.red)))
                                          ]),
                                    ]))))
                            .toList());
                  }))
        ])))));
  }
}
