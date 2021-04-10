import 'dart:async';
import 'dart:math';

import 'package:emergencybutton/database.dart';
import 'package:emergencybutton/maps.dart';
import 'package:emergencybutton/policedata.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './login.dart';
import './test.dart';
import './details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './ml_sound_prediction.dart';

class safetyButton extends StatefulWidget {
  String name;
  String email;
  String uid;
  safetyButton({this.email, this.name, this.uid});

  @override
  _safetyButtonState createState() =>
      _safetyButtonState(name: name, email: email, uid: uid);
}

class _safetyButtonState extends State<safetyButton> {
  String name;
  String email;
  String uid;
  _safetyButtonState({this.email, this.name, this.uid});
  bool loading = false;
  Timer timer;
  MachineLearning machineLearning = MachineLearning();
  @override
  void initState() {
    super.initState();
    machineLearning.initializemodel();
    if (name == null) {
      loading = true;
      sharekousekaro();
    }
  }

  callfunction() {
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
      var result = machineLearning.getResult();
      result.listen((event) async {
        print(event);
        print(event["recognitionResult"] + "okkkk");
        // this line outputs the predicted class
        if (event["recognitionResult"] == "1 Scream") {
          timer.cancel();
          await Database().getupdatepolice(false, true, uid);
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return mapsForClient(
              name: name,
              email: email,
              uid: uid,
            );
          }));
        }
      });
    });
  }

  void dispose() {
    timer?.cancel();
    setState(() {
      _security = false;
    });
    super.dispose();
  }

  sharekousekaro() async {
    await HelperFunctions.getUserNameSharedPreference().then((value) {
      setState(() {
        name = value;
      });
    });
    await HelperFunctions.getUserEmailSharedPreference().then((value) {
      setState(() {
        email = value;
      });
    });
    await HelperFunctions.getUserImageSharedPreference().then((value) {
      uid = value;
    });
    setState(() {
      loading = false;
    });
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  bool _security = false;

  Widget build(BuildContext context) {
    return loading == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            drawer: Drawer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Hello,$name",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'QuickSand',
                        letterSpacing: 2,
                        color: Color(0xFF9E7501)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Your Email: $email",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'QuickSand',
                        letterSpacing: 2,
                        color: Color(0xFF9E7501)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Uid: $uid",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'QuickSand',
                        letterSpacing: 2,
                        color: Color(0xFF9E7501)),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 60,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return mapsForClient(
                              name: name,
                              email: email,
                              uid: uid,
                            );
                          }));
                          print("open maps");
                        },
                        child: Row(
                          children: [
                            Icon(Icons.map),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Open Maps",
                              style: TextStyle(
                                  fontFamily: "QuickSand", fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    child: ButtonTheme(
                      height: 60,
                      minWidth: double.infinity,
                      child: FlatButton(
                        onPressed: () {
                          print("family  button pressed");
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return details();
                          }));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.track_changes),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Track Someone",
                                style: TextStyle(
                                    fontFamily: "QuickSand", fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 60,
                      child: FlatButton(
                        onPressed: () {
                          print("policebutton  button pressed");
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return policeDetails();
                          }));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.security),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Police Mode(only for UP Dial 100)",
                                style: TextStyle(
                                    fontFamily: "QuickSand", fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 60,
                      child: FlatButton(
                        onPressed: () async {
                          auth.signOut();
                          print("Signout Button pressed");
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Login();
                          }));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.logout),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Logout",
                                style: TextStyle(
                                    fontFamily: "QuickSand", fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: Text(
                "SALUTIS",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'QuickSand',
                    letterSpacing: 1.8,
                    color: Color(0xFF9E7501)),
              ),
              backgroundColor: Color(0xFF77DADA),
            ),
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Hello,\n$name",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'QuickSand',
                        letterSpacing: 2,
                        color: Color(0xFF9E7501)),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Image(
                    image: AssetImage("images/ws.png"),
                    height: 140,
                    width: 140,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    child: RaisedButton(
                      elevation: 20,
                      onPressed: () {
                        setState(() {
                          _security = !_security;
                          if (_security == true) {
                            callfunction();
                            Fluttertoast.showToast(msg: "Shield is Activated");
                          } else {
                            timer.cancel();
                            Fluttertoast.showToast(
                                msg: "Shield is Deactivated");
                          }
                        });
                      },
                      child: Icon(Icons.security,
                          size: 80,
                          color: _security == true
                              ? Colors.lightBlue
                              : Colors.black),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 60,
                      child: FlatButton(
                        color: Color(0xFF9E7501),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return mapsForClient(
                              name: name,
                              email: email,
                              uid: uid,
                            );
                          }));
                          print("open maps");
                        },
                        child: Text(
                          "Open Maps",
                          style: TextStyle(
                              fontFamily: "QuickSand",
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
  }
}
