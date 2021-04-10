import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class mapsForPolice extends StatefulWidget {
  String lang;
  String long;
  bool which_one;
  Set<Marker> points;
  mapsForPolice({this.lang, this.long, this.which_one, this.points});

  @override
  _mapsForPoliceState createState() => _mapsForPoliceState(
      lang: lang, long: long, which_one: which_one, points: points);
}

class _mapsForPoliceState extends State<mapsForPolice> {
  String lang;
  String long;
  bool which_one;
  Set<Marker> points;
  _mapsForPoliceState({this.lang, this.long, this.which_one, this.points});
  LatLng _center = LatLng(double.parse("26.722"), double.parse("76.2268"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Trace Location",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'QuickSand',
                letterSpacing: 1.8,
                color: Color(0xFF9E7501)),
          ),
          backgroundColor: Color(0xFF77DADA)),
      body: Stack(
        children: [
          GoogleMap(
              markers: which_one == true
                  ? points
                  : {
                      Marker(
                          markerId: MarkerId(_center.toString()),
                          position:
                              LatLng(double.parse(lang), double.parse(long)),
                          infoWindow: InfoWindow(title: "Emergency candidate"),
                          icon: BitmapDescriptor.defaultMarker)
                    },
              initialCameraPosition: which_one == true
                  ? CameraPosition(
                      target: LatLng(double.parse(lang), double.parse(long)),
                      zoom: 5)
                  : CameraPosition(
                      target: LatLng(double.parse(lang), double.parse(long)),
                      zoom: 18))
        ],
      ),
    );
  }
}
