//import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'networking.dart';

class login extends StatefulWidget {
  //const login({Key key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String pass = "";

  late SharedPreferences sp;
  void check() async{
    sp = await SharedPreferences.getInstance();
    if(sp.getBool('is_logged') == true){
      String a = sp.getString("location").toString();
      Navigator.pushNamedAndRemoveUntil(context, a, (route) => false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    check();
    super.initState();
    check();
    // pass = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
            "User Login",
          style: TextStyle(
            color: Colors.teal
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
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
                        backgroundImage:
                            AssetImage("picha/account1.jpg"),
                      )),
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                child: TextFormField(
                  //autovalidateMode: AutovalidateMode.always,
                  //controller: _email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Email',
                      hintText: 'eg. example@gmail.com'),
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "this field is empty";
                    } else {
                      email = value.toString();
                      //return value;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 10),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  //autovalidateMode: AutovalidateMode.always,
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Password',
                      hintText: '***********'),
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return "password cannot be empty!";
                    } else {
                      pass = value.toString();
                      //return value;
                    }
                  },
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Map data = {
                        "Email": email,
                        "Password": pass,
                      };
                      networking net = new networking();
                      String ans = await net.post(context, "login.php", data);

                      if (ans == "") {
                        Fluttertoast.showToast(msg: "error in getting data");
                      } else {
                        print(ans);


                        Map data = jsonDecode(ans);
                        if (data["message"] == true) {
                          sp.setBool("is_logged", true);
                          sp.setString("email", email);
                          sp.setString("name", data["name"]);

                          Fluttertoast.showToast(msg:"You are successfully to login ${data['role']}", backgroundColor: Colors.black);
                          if (data["role"] == "customer") {
                            sp.setString("location", "/CustomerHome");
                            Navigator.pushNamed(context, "/CustomerHome");
                          } else if (data["role"] == "admin") {
                            sp.setString("location", "/admin");
                            Navigator.pushNamed(context, "/admin");
                          } else {
                            sp.setString("location", "/staff");
                            Navigator.pushNamed(context, "/staff");
                          }
                        } else {
                          Fluttertoast.showToast(msg: "Wrong password or email", backgroundColor: Colors.black);
                        }
                      }
                    } else {
                      //Fluttertoast.showToast(msg: "PLEASE VERIFY FORM INPUTS FIRST!");
                    }
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/registration");
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('New User? Create Account')
            ],
          ),
        ),
      ),
    );
  }
}
