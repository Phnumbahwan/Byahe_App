import 'package:byahe_app/pages/commuter/locationselection.dart';
import 'package:byahe_app/pages/driver/pending.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:byahe_app/pages/login/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:byahe_app/pages/login_auth.dart';
import 'package:provider/provider.dart';
import 'package:byahe_app/pages/driver/onboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({ Key? key }) : super(key: key);
  static bool alley = false;
  static bool ping = false;
  static bool broadcast = false;
  static bool inboard = false;
  static bool commuter = false;
  static bool driver = true;
  static bool clicked_back = false;
  static bool clicked_forward = false;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Authenticate>(
          create: (_) => Authenticate(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<Authenticate>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        title: 'BYAHE',
        home: VerifySession(),
      ),
    );
  }
}

class VerifySession extends StatelessWidget {
  static String type = "";

  Future getUserType() async {
    String useruid = FirebaseAuth.instance.currentUser.uid;
    final docRef = FirebaseFirestore.instance.collection("users").doc(useruid);
    return await docRef.get().then(
      (DocumentSnapshot doc) async {
        final data = doc.data() as Map<String, dynamic>;
        print(data['user_type']);
        type = data['user_type'];
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  @override
  Widget build(BuildContext context) {
    //var currentUser = FirebaseAuth.instance.currentUser;
    String status = "ONLINE";
    final user = context.watch<User>();
    print(user);
    if (user != null) {
      context.read<Authenticate>().updateUserStatus(status);
      getUserType();
      print("DEBUGG : >>");
      if (type == "Driver") {
        return Onboard();
      } else if (type == "Commuter") {
        return LocationSelection();
      }
    }
    return LoginPage();
  }
}
