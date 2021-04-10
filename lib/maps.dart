import 'dart:async';
import 'dart:math';
import 'package:emergencybutton/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import './test.dart';

class mapsForClient extends StatefulWidget {
  String name;
  String email;
  String uid;
  mapsForClient({this.email, this.name, this.uid});

  @override
  _mapsForClientState createState() =>
      _mapsForClientState(name: name, email: email, docid: uid);
}

class _mapsForClientState extends State<mapsForClient> {
  String name;
  String email;
  String docid;
  _mapsForClientState({this.email, this.name, this.docid});
  bool lock = true;
  bool police = false;
  bool col = false;
  bool blockok = false; //false for firebase

  callmefirst() async {
    await Database().getpreviousdata(docid).then((val) {
      print(val.data()['police']);
      lock = val.data()['condition'];
      police = val.data()['police'];
    });
    setState(() {
      blockok = true;
    });
  }

  void initState() {
    print("$name $email $docid");
    super.initState();
    callmefirst();
  }

  void dispose() {
    setState(() {
      lock = true;
      police = false;
      blockok = false;
    });
    super.dispose();
    controller.dispose();
  }

  @override
  Completer<GoogleMapController> _controller = Completer();
  LatLng _center = const LatLng(27.22, 78.02424);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  GoogleMapController controller;
  cordinateSender(var lat, var long, var cond) async {
    await Database().getupdate(lat.toString(), long.toString(), cond, docid);
  }

  void onMapCreated(GoogleMapController _cntlr) {
    controller = _cntlr;

    _location.onLocationChanged.listen((l) {
      if (lock == false) {
        cordinateSender(l.latitude, l.longitude, lock);
      }
      _center = LatLng(l.latitude, l.longitude);
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 20),
        ),
      );
    });
  }

  Location _location = Location();
  Widget build(BuildContext context) {
    return blockok == false
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            floatingActionButton: Container(
              //padding: EdgeInsets.only(bottom: 40),
              height: 70,
              width: 70,
              child: FloatingActionButton(
                onPressed: () async {
                  if (police == true) {
                    Fluttertoast.showToast(
                        msg:
                            "Police mode is Activated can't stop location sharing");
                    return;
                  }
                  setState(() {
                    lock = !lock;
                  });
                  await Database().getupdatecondition(lock, docid);
                },
                tooltip: lock == true ? "Send Your Location" : "Cancel Sharing",
                backgroundColor: lock == true ? Colors.orange : Colors.red,
                child: Icon(
                  lock == true ? Icons.send : Icons.gps_fixed,
                  size: 30,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
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
            body: Stack(
              children: <Widget>[
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _center, zoom: 15),
                  onMapCreated: onMapCreated,
                  markers: {
                    Marker(
                        markerId: MarkerId(_center.toString()),
                        position: _center,
                        infoWindow: InfoWindow(title: "Your Location"),
                        icon: BitmapDescriptor.defaultMarker)
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 125, right: 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              _location = Location();
                              col = !col;
                            });
                          },
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          color: Color(0xFFEBE5E5),
                          child: Icon(
                            Icons.gps_fixed_outlined,
                            size: 30,
                            color: col == false
                                ? Colors.black45
                                : Colors.blueAccent,
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 125, left: 20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: RaisedButton(
                          onPressed: () async {
                            setState(() {
                              police = !police;
                              lock = !lock;
                            });
                            await Database()
                                .getupdatepolice(lock, police, docid);
                          },
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          color: police == false ? Colors.green : Colors.red,
                          child: police == false
                              ? Icon(
                                  Icons.shield,
                                  size: 30,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.shield,
                                  size: 40,
                                )),
                    ),
                  ),
                ),
              ],
            ));
  }
}
