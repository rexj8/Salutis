import 'package:flutter/material.dart';
import './Homepage.dart';
import './login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './signup.dart';
import './test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  bool isUserLogedin = false;
  void initState() {
    getuserdetails();
  }

  Widget build(BuildContext context) {
    return isUserLogedin == true ? safetyButton() : Login();
  }

  void getuserdetails() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      if (value != null) {
        setState(() {
          isUserLogedin = value;
        });
      }
    });
  }
}
