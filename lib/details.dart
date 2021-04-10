//import 'dart:html';

import 'package:flutter/material.dart';

import './KnowMore.dart';

class details extends StatelessWidget {
  // const details({Key key}) : super(key: key);
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF018C9E),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 80,
              color: Colors.white,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Color(0xFFF0F5F7),
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
                    color: Colors.black,
                  ),
                  hintText: 'Enter Email',
                  hintStyle: TextStyle(
                    color: Colors.black26,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 60,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return KnowMore(
                      email: email.text,
                    );
                  }));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Search",
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
