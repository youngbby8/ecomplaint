import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Login Form';

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  @override
  Widget build(BuildContext context) {
    var _fullname = TextEditingController();
    var _email = TextEditingController();
    var _address = TextEditingController();
    var _phone = TextEditingController();
    var _password = TextEditingController();
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Basic Information ",
              textAlign: TextAlign.left,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: TextField(
                controller: _fullname,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                    hintText: 'Enter your full name'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter your email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 10),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: '***********'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: TextField(
                controller: _address,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                    hintText: 'Enter your address'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: TextField(
                controller: _phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                    hintText: 'Enter your phone number'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () async {
                  //  +_email.value+_password.value+_address.value+_phone.value

                  Uri url = Uri.parse(
                      "http://10.4.11.210/ecomplains/API/register.php");
                  var request = await http.post(url,
                      body: jsonEncode({
                        "Fullname": _fullname.text,
                        "Address": _address.text,
                        "Phoneno": _phone.text,
                        "Email": _email.text,
                        "Password": _password.text
                      }));
                  print(request.body);
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => Register()));
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
