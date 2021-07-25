import 'dart:async';

import 'package:ecomplains/pages/admin.dart';
import 'package:ecomplains/pages/complaints.dart';
import 'package:ecomplains/pages/customerComplaint.dart';
import 'package:ecomplains/pages/callcenter.dart';
import 'package:ecomplains/pages/staffcomplaint.dart';
import 'package:ecomplains/pages/techcomplaint.dart';
import 'package:ecomplains/pages/technician.dart';
import 'package:ecomplains/pages/tools.dart';
import 'package:flutter/material.dart';
import 'package:ecomplains/pages/login.dart';
import 'package:ecomplains/pages/registration.dart';
import 'package:ecomplains/pages/ComplaintForm.dart';
import 'package:ecomplains/pages/CustomerHome.dart';

import 'RegistrationForm.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/login": (context) => login(),
        "/registration": (context) => registration(),
        "/ComplaintForm": (context) => ComplaintForm(),
        "/CustomerHome": (context) => CustomerHome(),
        "/customerComplaint": (context) => customerComplaint(),
        "/admin": (context) => admin(),
        "/staff": (context) => staff(),
        "/tools": (context) => tools(),
        "/complaints": (context) => complaints(),
        "/staffcomplaints": (context) => staffcomplaint(),
        "/technician": (context) => technician(),
        "/techcomplaint": (context) => techcomplaint(),
      },
      home: mainActivity(),
    ));

class mainActivity extends StatefulWidget {
  const mainActivity({Key? key}) : super(key: key);

  @override
  _mainActivityState createState() => _mainActivityState();
}

class _mainActivityState extends State<mainActivity> {

  void fungua(context) async{
    Timer(Duration(seconds: 2), () {
      // 5s over, navigate to a new page
      //print("System ipo main page inaenda $location");
      //Navigator.pushNamed(context, '/$location');
      Navigator.pushNamedAndRemoveUntil(context, "/login", (Route<dynamic> route) => false);

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fungua(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Main Page"),
      // ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "picha/flash.png"
                  ),
                  fit: BoxFit.contain

              )
          ),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(),
              ),
              Expanded(
                flex: 4,
                child: Container(),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "E-Complains",
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}