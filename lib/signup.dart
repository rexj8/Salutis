import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './database.dart';
import './Homepage.dart';
import './test.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController ph1 = TextEditingController();
  TextEditingController ph2 = TextEditingController();
  TextEditingController ph3 = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  User _user;
  bool _isloading = false;
  _submitButton() async {
    setState(() {
      _isloading = true;
    });
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      User firebaseuser = result.user;
      if (firebaseuser != null) {
        _user = FirebaseAuth.instance.currentUser;

        Map<String, dynamic> user = {
          "userEmail": email.text,
          "userName": name.text,
          "ph1": ph1.text,
          "ph2": ph2.text,
          "ph3": ph3.text,
          "x": "",
          "y": "",
          "TimeStamp": DateTime.now(),
          "police": false,
          "condition": true,
          "user_uid": _user.uid
        };
        await Database().addUserDetails(user, _user.uid);
        await HelperFunctions.saveUserLoggedInSharedPreference(true);
        HelperFunctions.saveUserEmailSharedPreference(email.text);
        HelperFunctions.saveUserNameSharedPreference(name.text);
        HelperFunctions.saveUserImageSharedPreference(_user.uid);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return safetyButton(
            name: name.text,
            email: email.text,
            uid: _user.uid,
          );
        }));
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isloading == true
        ? Center(
            child: CircularProgressIndicator(),
          )
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
                    "Create Account and Be Safe",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
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
                      controller: name,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        hintText: 'Enter Your Name',
                        hintStyle: TextStyle(
                          color: Colors.white54,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
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
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        hintText: 'Enter Your Email',
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
                      controller: ph1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        hintText: 'Enter your relatives ph',
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
                      controller: ph2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        hintText: "Enter your relatives ph",
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
                      controller: ph3,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        hintText: 'Enter your relatives ph',
                        hintStyle: TextStyle(
                          color: Colors.white54,
                          fontFamily: 'OpenSans',
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
                          _submitButton();
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
                    height: 20,
                  )
                ],
              ),
            ),
          );
  }
}
