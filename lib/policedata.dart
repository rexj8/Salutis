import 'package:emergencybutton/database.dart';
import 'package:emergencybutton/policeMap.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class policeDetails extends StatefulWidget {
  policeDetails({Key key}) : super(key: key);

  @override
  _policeDetailsState createState() => _policeDetailsState();
}

class _policeDetailsState extends State<policeDetails> {
  void initState() {
    super.initState();
    getdetails();
  }

  var block;
  List<Widget> list = List<Widget>();
  Set<Marker> points = Set<Marker>();
  getdetails() async {
    await Database().getdetails().then((val) {
      setState(() {
        block = val;
        print(block.docs.length);
      });
    });
    for (int i = 0; i < block.docs.length; i++) {
      var x = block.docs[i].data()['x'];
      var y = block.docs[i].data()['y'];
      var name = block.docs[i].data()['userName'];
      var email = block.docs[i].data()['userEmail'];

      var time = block.docs[i].data()['TimeStamp'];
      list.add(detailsBlock(
        name: name,
        x: x,
        y: y,
        email: email,
        time:
            DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000).toString(),
      ));
      points.add(getMarkerdetails(x, y, name, email));
    }
  }

  getMarkerdetails(String x, String y, String name, String email) {
    return Marker(
        markerId: MarkerId(email),
        position: LatLng(double.parse(x), double.parse(y)),
        infoWindow: InfoWindow(title: "Name: $name  Email: $email"),
        icon: BitmapDescriptor.defaultMarker);
  }

  containblock(String x, String y, String time) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return mapsForPolice(
            lang: x,
            long: y,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border.all(color: Colors.amber)),
        child: Column(
          children: [Text("$x"), Text("$y"), Text("$time")],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return block == null
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.amber,
            ),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  print(points);
                  return mapsForPolice(
                    points: points,
                    which_one: true,
                    lang: "28.7041",
                    long: "77.1025",
                  );
                }));
              },
              child: Icon(Icons.remove_red_eye_outlined),
            ),
            appBar: AppBar(
              title: Text(
                "Emergency Help",
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
            body: ListView(
              children: list,
            ),
          );
  }
}

class detailsBlock extends StatelessWidget {
  String x;
  String y;
  String time;
  String email;
  String name;
  detailsBlock({this.x, this.y, this.time, this.email, this.name});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              // ignore: missing_return
              MaterialPageRoute(builder: (BuildContext context) {
            return mapsForPolice(
              lang: x,
              long: y,
              which_one: false,
            );
          }));
        },
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(border: Border.all(color: Colors.amber)),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(" Name:- $name"),
              SizedBox(
                height: 10,
              ),
              Text(" Email:- $email"),
              SizedBox(
                height: 10,
              ),
              Text("latitude: $x"),
              SizedBox(
                height: 10,
              ),
              Text(" longitude $y"),
              SizedBox(
                height: 10,
              ),
              Text("TimeUpdate:- $time"),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
