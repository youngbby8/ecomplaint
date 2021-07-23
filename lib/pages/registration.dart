import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'networking.dart';

class registration extends StatefulWidget {
  //const registration({Key key}) : super(key: key);

  @override
  _registrationState createState() => _registrationState();
}

class _registrationState extends State<registration> {
  final appTitle = 'Registration';
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String email = "";
  String address = "";
  String phone = "";
  String password = "";
  bool fbody = false;
  late Widget iptisam;

  @override
  Widget build(BuildContext context) {
    if (!fbody) {
      iptisam = iptiform();
    } else {
      iptisam = Container();
    }

    return MaterialApp(
        title: appTitle,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text(appTitle),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: iptisam,
          ),
        ));
  }

  Widget iptiform() {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("picha/account1.jpg"),
                    )),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Full Name',
                    hintText: 'Enter your full name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Fill the field";
                  } else {
                    name = value;
                  }
                },
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Email',
                    hintText: 'Enter your email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Fill the field";
                  } else {
                    email = value;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 10),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Password',
                    hintText: '***********'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Fill the field";
                  } else if (value.length < 8) {
                    return "password too short";
                  } else {
                    password = value;
                  }
                },
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Address',
                    hintText: 'Enter your address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Fill the field";
                  } else {
                    address = value;
                  }
                },
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Phone Number',
                    hintText: 'Enter your phone number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Fill the field";
                  } else if (value.length < 10) {
                    return "Number too short";
                  } else {
                    phone = value;
                  }
                },
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Map data = {
                      "Fullname": name,
                      "Email": email,
                      "Password": password,
                      "Address": address,
                      "Phoneno": phone
                    };

                    networking net = new networking();
                    String ans = await net.post(context, "register.php", data);

                    if (ans == "") {
                      Fluttertoast.showToast(msg: "error in getting data");
                    } else {
                      print(ans);

                      Map data = jsonDecode(ans);
                      if (data["message"] == true) {
                        Fluttertoast.showToast(msg:"customer registered successfully", backgroundColor: Colors.black);
                        setState(() {
                          fbody = !fbody;
                        });
                      } else {
                        Fluttertoast.showToast(msg: "failed to register customer", backgroundColor: Colors.black);
                      }
                    }

                  } else {
                    print("could not validate form");
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Always have an account ?')
          ],
        ));
  }
}
