import 'package:flutter/material.dart';
import './database.dart';
import './policeMap.dart';

class KnowMore extends StatefulWidget {
  String email;
  KnowMore({this.email});

  @override
  _KnowMoreState createState() => _KnowMoreState(email: email);
}

class _KnowMoreState extends State<KnowMore> {
  String email;
  _KnowMoreState({this.email});
  String Name;
  String Email;
  String x;
  String y;
  String ph1;
  String ph2;
  String ph3;
  bool isloading = true;
  void initState() {
    getuserdetails();
    super.initState();
  }

  getuserdetails() async {
    await Database().getuserdetails(email).then((val) {
      setState(() {
        Name = val.docs[0].data()['userName'];
        x = val.docs[0].data()['x'];
        y = val.docs[0].data()['y'];
        // phone number -1
        ph1 = val.docs[0].data()['ph1'];
        // phone number -2
        ph2 = val.docs[0].data()['ph2'];
        // phone number -3
        ph3 = val.docs[0].data()['ph3'];
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isloading == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Color(0xFF018C9E),
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.details,
                    size: 100,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.person),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "$Name",
                            style: TextStyle(
                                fontFamily: "QuickSand", fontSize: 20),
                          ),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.email),
                          SizedBox(
                            width: 10,
                          ),
                          Text("$email",
                              style: TextStyle(
                                  fontFamily: "QuickSand", fontSize: 20)),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.location_city),
                          SizedBox(
                            width: 10,
                          ),
                          Text("$x",
                              style: TextStyle(
                                  fontFamily: "QuickSand", fontSize: 20)),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.location_city),
                          SizedBox(
                            width: 10,
                          ),
                          Text("$y",
                              style: TextStyle(
                                  fontFamily: "QuickSand", fontSize: 20)),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.phone_android),
                          SizedBox(
                            width: 10,
                          ),
                          Text("$ph1",
                              style: TextStyle(
                                  fontFamily: "QuickSand", fontSize: 20)),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.phone_android),
                          SizedBox(
                            width: 10,
                          ),
                          Text("$ph2",
                              style: TextStyle(
                                  fontFamily: "QuickSand", fontSize: 20)),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.phone_android),
                          SizedBox(
                            width: 10,
                          ),
                          Text("$ph3",
                              style: TextStyle(
                                  fontFamily: "QuickSand", fontSize: 20)),
                        ],
                      )),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return mapsForPolice(
                            lang: x,
                            long: y,
                            which_one: false,
                          );
                        }));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Trace",
                        style: TextStyle(
                            fontFamily: 'QuickSand',
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
