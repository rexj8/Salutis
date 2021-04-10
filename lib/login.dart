import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './signup.dart';
import './database.dart';
import './test.dart';
import './Homepage.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isloading = false;
  _onlogin() async {
    setState(() {
      _isloading = true;
    });
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      if (result != null) {
        //dosomething
        var user = await Database().getuserdetails(email.text);
        String _email = email.text;
        String _name = user.docs[0].data()['userName'];
        String _uid = user.docs[0].data()['user_uid'];
        await HelperFunctions.saveUserLoggedInSharedPreference(true);
        HelperFunctions.saveUserEmailSharedPreference(_email);
        HelperFunctions.saveUserNameSharedPreference(_name);
        HelperFunctions.saveUserImageSharedPreference(_uid);
        print("$_email, $_name, $_uid");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return safetyButton(
            name: _name,
            email: email.text,
            uid: _uid,
          );
        }));
      } else {
        setState(() {
          _isloading = false;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.black,
          fontSize: 14.0);
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isloading == true
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Color(0xFF205B8B),
                Color(0xFF77DADA),
              ])),
              child: ListView(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "SALUTIS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'QuickSand',
                        letterSpacing: 2,
                        color: Color(0xFF9E7501)),
                  ),
                  Image(
                    image: AssetImage("images/ws.png"),
                    height: 140,
                    width: 140,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                        top: 20, bottom: 10, left: 20, right: 20),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color(0xFF50ABC7),
                        border: Border.all(color: Colors.amber),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        hintText: 'Enter Email',
                        hintStyle: TextStyle(
                          color: Colors.white54,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color(0xFF50ABC7),
                        border: Border.all(color: Colors.amber),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      obscureText: true,
                      controller: password,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        hintText: 'Enter your Password',
                        hintStyle: TextStyle(
                          color: Colors.white54,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: RaisedButton(
                        onPressed: () {
                          _onlogin();
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontFamily: 'QuickSand',
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Signup();
                          }));
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Create a account",
                          style: TextStyle(
                              fontFamily: 'QuickSand',
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    "  Design & Devloped by Team-Three Duckies for Hack36",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "QuickSand",
                        fontSize: 15),
                  )
                ],
              ),
            ),
          );
  }
}
