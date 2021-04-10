import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Future<void> addUserDetails(Map user, String uid) async {
    await FirebaseFirestore.instance
        .collection("userLocation")
        .doc(uid)
        .set(user)
        .catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  Future<void> getupdate(String x, String y, bool cond, String docid) async {
    await FirebaseFirestore.instance
        .collection("userLocation")
        .doc(docid)
        .update({
      "x": x,
      "y": y,
      "condition": cond,
      "TimeStamp": DateTime.now()
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  Future<void> getupdatecondition(bool cond, String docid) async {
    await FirebaseFirestore.instance
        .collection("userLocation")
        .doc(docid)
        .update({"condition": cond}).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  Future<void> getupdatepolice(bool cond, bool pol, String docid) async {
    await FirebaseFirestore.instance
        .collection("userLocation")
        .doc(docid)
        .update({"condition": cond, "police": pol}).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  getdetails() async {
    return await FirebaseFirestore.instance
        .collection("userLocation")
        .where("police", isEqualTo: true)
        .get();
  }

  getuserdetails(String email) async {
    return await FirebaseFirestore.instance
        .collection("userLocation")
        .where("userEmail", isEqualTo: email)
        .get();
  }

  getpreviousdata(String docid) async {
    return await FirebaseFirestore.instance
        .collection("userLocation")
        .doc(docid)
        .get();
  }
}
