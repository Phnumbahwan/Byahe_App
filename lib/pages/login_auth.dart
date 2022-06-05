import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Authenticate {
  final FirebaseAuth _auth;

  Authenticate(this._auth);

  Stream<User> get authStateChanges => _auth.idTokenChanges();

  Future<String> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Logged In";
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<String> signupCommuter(String email, String password) async {
    String userType;
    String name;
    //bool queue = false;
    String status;
    //bool state = false;

    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        User user = FirebaseAuth.instance.currentUser;

        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "uid": user.uid,
          'full_name': name,
          "user_type": userType,
          //'queue': queue,
          'status': status,
          //'state': state,
          "email": email,
          "password": password,
        });
      });
      return "Successfully Signed In";
    } on FirebaseAuthException catch (error) {
      return error.toString();
    }
  }

  Future respondBooking(var fnamePlate, var response) {
    return FirebaseFirestore.instance
        .collection('bookings')
        .doc(fnamePlate)
        .update({'status': response})
        .then((value) => print('Successfully accepted the booking request'))
        .catchError((onError) => print('Failed to accept request: $onError'));
  }

  Future bookings() async {
    String status;
    String useruid = FirebaseAuth.instance.currentUser.uid;
    // ignore: non_constant_identifier_names
    var vehicle_plate;
    var drivername;
    var fname;
    var fnamePlate;
    var gender;
    var address;
    var number;
    var numpass;
    var date;
    var uid;
    var date_applied;
    await FirebaseFirestore.instance
        .collection('bookings')
        .doc(/*fnamePlate*/)
        .set({
          'date_applied': date_applied,
          'applicant_reference': uid,
          'status': status,
          'plate_reference': vehicle_plate,
          'driver_name': drivername,
          "customer_name": fname,
          'gender': gender,
          'address': address,
          'contact_number': number,
          'number_of_passengers': numpass,
          'date_to_reserve': date,
        })
        .then((value) => print('Booking sent'))
        .catchError((onError) => print('Failed to add booking: $onError'));
  }

  Future<String> signupDriver(String email, String password) async {
    String fname;
    String lname;
    String jeepline;
    String jeeproute;
    String mobnum;
    String platenum;
    String userType;
    String vehicle_status;
    String status = "ONLINE";
    bool broadcast = false;
    String route_path;
    int seats_avail;
    bool queue = false;
    int current_occupied;
    String alley_time;
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        User user = FirebaseAuth.instance.currentUser;

        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          'uid': user.uid,
          'user_type': userType,
          'email': email,
          'password': password,
          'first_name': fname,
          'last_name': lname,
          'jeepney_line': jeepline,
          'jeepney_route': jeeproute,
          'route_path': route_path,
          'seats_avail': seats_avail,
          'mobile_number': mobnum,
          'vehicle_plate_number': platenum,
          'vehicle_status': vehicle_status,
          'current_occupied': current_occupied,
          'broadcast': broadcast,
          'status': status,
          'alley_time': alley_time,
        });
      });
      return "Successfully Signed In";
    } on FirebaseAuthException catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future retrieveName() async {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    String name;
    DocumentSnapshot usercat =
        await FirebaseFirestore.instance.collection('users').doc(useruid).get();
    if (usercat['user_type'] == "Commuter") {
      name = usercat['full_name'];
      return name;
    } else if (usercat['user_type'] == "Driver") {
      name = usercat['last_name'];
      return name;
    }
  }

  Future retrieveUsertype() async {
    String usertype;
    String useruid = FirebaseAuth.instance.currentUser.uid;
    DocumentSnapshot usercat =
        await FirebaseFirestore.instance.collection('users').doc(useruid).get();
    usertype = usercat['user_type'];
    return usertype;
  }

  Future updateVehicleStatus(String status, alley_time) {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(useruid)
        .set({'vehicle_status': status, 'alley_time': alley_time},
            SetOptions(merge: true))
        .then((value) => print('Status updated'))
        .catchError((onError) => print('Failed to update status: $onError'));
  }

  Future retrieveVehicleStatus() async {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    String vehicle_status;
    DocumentSnapshot usercat =
        await FirebaseFirestore.instance.collection('users').doc(useruid).get();
    vehicle_status = usercat['vehicle_status'];
    return vehicle_status;
  }

  Future updateUserStatus(String status) {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(useruid)
        .update({'status': status})
        .then((value) => print('User now online'))
        .catchError((onError) => print('Failed to update status: $onError'));
  }

  Future getLocationList() async {
    List locationList = [];

    try {
      await FirebaseFirestore.instance
          .collection('locations')
          .get()
          .then((query) {
        query.docs.forEach((doc) {
          locationList.add(doc.data());
        });
      });
      return locationList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getSubrouteList() async {
    List subrouteList = [];

    try {
      await FirebaseFirestore.instance
          .collection('subroutes')
          .get()
          .then((query) {
        query.docs.forEach((doc) {
          subrouteList.add(doc.data());
        });
      });
      return subrouteList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // ignore: non_constant_identifier_names
  Future getAlleyList() async {
    List alleyList = [];

    try {
      await FirebaseFirestore.instance.collection('users').get().then((query) {
        query.docChanges.forEach((document) {
          alleyList.add(document.doc.data());
          //alleyList.hashCode;
        });
      });
      return alleyList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getDriverRoutePath() async {
    String driverRoute;
    String useruid = FirebaseAuth.instance.currentUser.uid;
    DocumentSnapshot usercat =
        await FirebaseFirestore.instance.collection('users').doc(useruid).get();
    driverRoute = usercat['route_path'];
    return driverRoute;
  }

  /*Future displayBookings() async {
    List bookingList = [];

    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .get()
          .then((query) {
        query.docs.forEach((doc) {
          bookingList.add(doc.data());
        });
      });
      return bookingList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }*/

  Future displayBookings() async {
    List bookingList = [];

    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .get()
          .then((query) {
        query.docChanges.forEach((doc) {
          bookingList.add(doc.doc.data());
        });
      });
      return bookingList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getDriverInfoDetails(String email) async {
    List driverDetails = [];

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get()
          .then((query) {
        query.docs.forEach((doc) {
          driverDetails.add(doc.data());
        });
      });
      return driverDetails;
    } catch (e) {
      return e.toString();
    }
  }

  Future getRouteListDetails(String location) async {
    List routeList = [];

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('jeepney_line', isEqualTo: location)
          .get()
          .then((query) {
        query.docs.forEach((doc) {
          routeList.add(doc.data());
        });
      });
      return routeList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getLat() async {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    var latitude;
    DocumentSnapshot usercat =
        await FirebaseFirestore.instance.collection('users').doc(useruid).get();

    latitude = usercat['latitude'];
    return latitude;
  }

  Future getBroadcastStatus() async {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    var broadcast;
    DocumentSnapshot usercat =
        await FirebaseFirestore.instance.collection('users').doc(useruid).get();
    broadcast = usercat['broadcast'];
    return broadcast;
  }

  Future getPlate() async {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    var plate;
    DocumentSnapshot usercat =
        await FirebaseFirestore.instance.collection('users').doc(useruid).get();

    plate = usercat['vehicle_plate_number'];
    return plate;
  }

  Future getPingStatus() async {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    var ping_status;
    DocumentSnapshot usercat =
        await FirebaseFirestore.instance.collection('users').doc(useruid).get();
    ping_status = usercat['ping_status'];
    return ping_status;
  }

  Future getLong() async {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    var longitude;
    DocumentSnapshot usercat =
        await FirebaseFirestore.instance.collection('users').doc(useruid).get();

    longitude = usercat['longitude'];
    return longitude;
  }

  Future getEmail() async {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    var email;
    DocumentSnapshot usercat =
        await FirebaseFirestore.instance.collection('users').doc(useruid).get();
    email = usercat['email'];
    return email;
  }

  Future updateQueueStatus(bool status) {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(useruid)
        .update({'queue': status})
        .then((value) => print('Queue status updated'))
        .catchError((onError) => print('Failed to update status: $onError'));
  }

  Future getCommuterQueueStatus() async {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    var queue;
    DocumentSnapshot usercat =
        await FirebaseFirestore.instance.collection('users').doc(useruid).get();
    queue = usercat['queue'];
    return queue;
  }

  Future updateBroadCast(bool status) {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(useruid)
        .update({'broadcast': status})
        .then((value) => print('Broadcast Status updated'))
        .catchError((onError) => print('Failed to update status: $onError'));
  }

  Future getTotalDriversRegistered() async {
    var counter = 0;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('user_type', isEqualTo: "Driver")
          .where('status', isEqualTo: "ONLINE")
          .get()
          .then((query) {
        query.docs.forEach((element) {
          counter++;
        });
      });
      return counter;
    } catch (e) {
      return e.toString();
    }
  }

  Future getTotalDriversInRoute(route_path) async {
    var counter = 0;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('route_path', isEqualTo: route_path)
          .where('user_type', isEqualTo: "Driver")
          .where('status', isEqualTo: 'ONLINE')
          .get()
          .then((query) {
        query.docs.forEach((doc) {
          counter++;
        });
      });
      return counter++;
    } catch (e) {
      return e.toString();
    }
  }

  Future getDriverRoute() async {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    var driverRoute;

    DocumentSnapshot usercat =
        await FirebaseFirestore.instance.collection('users').doc(useruid).get();
    driverRoute = usercat['route_path'];
    return driverRoute;
  }

  Future<void> clearPing() {
    var ping_status = 'Cancelled';
    String useruid = FirebaseAuth.instance.currentUser.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(useruid)
        .update({
          //'latitude': null,
          //'longitude': null,
          'ping_status': ping_status,
          'pinged_driver': null,
          'place_in_words': null,
          'ping_time': null,
        })
        .then((value) => print('Updated Ping Status: Cancelled'))
        .catchError((onError) =>
            print('Failed to clear Commuter Current LandMark: $onError'));
  }

  //changed from .update to .set
  Future<void> updatePing(var driveruid, time) {
    var ping_status = "Pending";
    String useruid = FirebaseAuth.instance.currentUser.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(useruid)
        .set({
          'ping_status': ping_status,
          'pinged_driver': driveruid,
          'ping_time': time,
        }, SetOptions(merge: true))
        .then((value) => print('Update Ping Status: Pending'))
        .catchError(
            (onError) => print('Failed to Update Ping Status into Pending'));
  }

  Future getPendingPingList(/*var vehicle_plate_number*/) async {
    List pingList = [];
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('user_type', isEqualTo: 'Commuter')
          .where('ping_status', isEqualTo: 'Pending')
          //.where('pinged_driver', isEqualTo: vehicle_plate_number)
          .get()
          .then((query) {
        query.docs.forEach((doc) {
          pingList.add(doc.data());
        });
      });
      return pingList;
    } catch (e) {
      return e.toString();
    }
  }

  Future pingResponse(var user_uid, var ping_status) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user_uid)
        .update({'ping_status': ping_status})
        .then((value) =>
            print('Successfully updated ping status into $ping_status'))
        .catchError(
            (onError) => print('Failed to update ping_status: $onError'));
  }

  Future resetPing(var user_uid) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user_uid)
        .update({
          'ping_status': null,
          'pinged_driver': null,
          'place_in_words': null,
        })
        .then((value) => print('Successfully reset Ping'))
        .catchError((onError) =>
            print('Failed to reset Ping (onboard.dart): $onError'));
  }

  Future getAcceptedPingList() async {
    List pingList = [];
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('user_type', isEqualTo: "Commuter")
          .where('ping_status', isEqualTo: "Onboard")
          //.where('pinged_driver', isEqualTo: vehicle_plate_number)
          .get()
          .then((query) {
        query.docs.forEach((doc) {
          pingList.add(doc.data());
        });
      });
      return pingList;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateOccupied(int current_occupied) async {
    String useruid = FirebaseAuth.instance.currentUser.uid;

    await FirebaseFirestore.instance.collection('users').doc(useruid).set({
      "current_occupied": current_occupied,
    }, SetOptions(merge: true));
  }

  Future getOccupied() async {
    var current_occupied;
    String useruid = FirebaseAuth.instance.currentUser.uid;
    DocumentSnapshot usercat =
        await FirebaseFirestore.instance.collection('users').doc(useruid).get();
    current_occupied = usercat['current_occupied'];
    return current_occupied;
  }

  Future getSeatCapacity() async {
    var max_cap;
    String useruid = FirebaseAuth.instance.currentUser.uid;
    DocumentSnapshot usercat =
        await FirebaseFirestore.instance.collection('users').doc(useruid).get();
    max_cap = usercat['seats_avail'];
    return max_cap;
  }
}
