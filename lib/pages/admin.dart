import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'networking.dart';

class admin extends StatefulWidget {
  const admin({Key? key}) : super(key: key);

  @override
  _adminState createState() => _adminState();
}

class _adminState extends State<admin> {
  TextEditingController contr = TextEditingController();
  String dat = "";
  final _formKey = GlobalKey<FormState>();
  List users = [];

  String name = "";
  String email = "";
  String address = "";
  String phone = "";
  String password = "";
  String valu = "";


  Future<String> getvalue(context) async{

    networking net = new networking();
    String ans = await net.get(context, "getusers.php");
    if (ans == "") {
      Fluttertoast.showToast(msg: "error fetching categories and institutions");
      return "";
    } else {
      print(ans);
      Map data = jsonDecode(ans);
      if (data["message"] == true) {
        users = data['user'];

        print(data);
        return "yeeeey";
      } else {
        Fluttertoast.showToast(msg: "API ERROR", backgroundColor: Colors.black);
        return "";
      }
    }



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Administrator",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),

      body: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 20),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(flex: 2, child: Container(),),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            child: Image(
                              image: AssetImage(
                                  "picha/account1.jpg"
                              ),
                            ),
                          ),
                          RaisedButton.icon(
                              onPressed: () async{
                                SharedPreferences sp = await SharedPreferences.getInstance();
                                sp.setBool("is_logged", false);
                                sp.setString("email", "");
                                sp.setString("name", "");
                                Navigator.pushNamedAndRemoveUntil(context, "/login", (Route<dynamic> route) => false);
                              },
                              icon: Icon(Icons.power_settings_new),
                              label: Text("Log Out"),
                          )
                        ],
                      ),
                    )
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 40, 0, 30),
                      child: Column(
                        children: [
                          Text(
                            "Administrator",
                            style: TextStyle(
                                color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Divider(),
                          Text(
                            "e_complaints.org",
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: Container(),),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[

                    GestureDetector(
                      onTap: (){
                        showDialog(
                          barrierLabel: "Register Category",
                          context: context,
                          builder: (context) {
                            String d = "technician";
                            return AlertDialog(
                              scrollable: true,
                              content: StatefulBuilder(builder: (context, setState) {
                                return Container(
                                  width: double.infinity,
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
                                          Padding(
                                            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                                            child: DropdownButton(
                                                isExpanded: true,
                                                //value: "$valu",
                                                items: [
                                                  DropdownMenuItem(
                                                    child: Text("call-center"),
                                                    value: "call-center",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text("technician"),
                                                    value: "technician",
                                                  )
                                                ],
                                                onChanged: (val) {
                                                  print(val);
                                                  valu = val.toString();
                                                  setState(() {
                                                    d = val.toString();
                                                    valu = val.toString();
                                                  });
                                                },
                                                hint: Text("$valu")),
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
                                                    "name": name,
                                                    "Email": email,
                                                    "Password": password,
                                                    "Address": address,
                                                    "Phoneno": phone,
                                                    "role" : valu
                                                  };

                                                  networking net = new networking();
                                                  String ans = await net.post(context, "register.php", data);

                                                  if (ans == "") {
                                                    Fluttertoast.showToast(msg: "error in getting data");
                                                  } else {
                                                    print(ans);

                                                    Map data = jsonDecode(ans);
                                                    if (data["message"] == true) {
                                                      Navigator.pop(context);
                                                      Fluttertoast.showToast(msg:"customer registered successfully", backgroundColor: Colors.black);
                                                    } else {
                                                      Navigator.pop(context);
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
                                          Text('Already have an account ?')
                                        ],
                                      )),
                                );
                              }),
                            );
                          },
                        );
                      },


                      child: Card(
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        //color: Color.fromRGBO(0, 0, 80, 0.8),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: Column(
                            children: [
                              Icon(
                                  Icons.person_add,
                                color: Colors.white,
                              ),
                              Divider(),
                              Text(
                                "Register Staff",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),

                      ),
                    ),


                    GestureDetector(

                      onTap: (){
                        showDialog(
                          barrierLabel: "",
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            scrollable: true,
                            content: Builder(builder: (context) {
                              return FutureBuilder(
                                future: getvalue(context),
                                initialData: "loading....",
                                builder: (BuildContext context, AsyncSnapshot<String> T){
                                  return Column(
                                    children: users.map((e) {
                                      return Card(
                                        child: ListTile(
                                          leading: Icon(Icons.account_circle_outlined),
                                          trailing: Text(
                                            "${e['role']}",
                                            style: TextStyle(
                                              color: e['role'] == "admin" ? Colors.red : e['role'] == "staff" ? Colors.teal : Colors.blueAccent,
                                            ),
                                          ),
                                          title: Text(
                                            "${e['full_name']}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                              );
                            }),
                          ),
                        );
                      },

                      child: Card(
                        color: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        //color: Color.fromRGBO(0, 0, 80, 0.8),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.people,
                                color: Colors.white,
                              ),
                              Divider(),
                              Text(
                                "View Users",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),

                      ),
                    ),


                    GestureDetector(
                      onTap: (){
                        showDialog(
                          barrierLabel: "Register Category",
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            content: Builder(builder: (context) {
                              return Container(
                                height: 350,
                                child: Column(
                                  children: [
                                    Text("Add new Category"),
                                    Divider(),
                                    Divider(),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15.0, top: 15, bottom: 10),
                                      //padding: EdgeInsets.symmetric(horizontal: 15),
                                      child: TextFormField(
                                        //autovalidateMode: AutovalidateMode.always,
                                        controller: contr,
                                        //obscureText: true,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            labelText: 'Category name',
                                            hintText: 'name of category'),
                                        validator: (value) {
                                          if (value.toString().isEmpty) {
                                            return "password cannot be empty!";
                                          } else {
                                            dat = value.toString();
                                            //return value;
                                          }
                                        },
                                        onChanged: (value) {
                                          dat = value.toString();
                                        },
                                      ),
                                    ),

                                    Divider(),

                                    Container(
                                      height: 50,
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(20)),
                                      child: FlatButton(
                                        onPressed: () async {
                                          if(dat.isNotEmpty){
                                            Map data = {"name" : dat};
                                            networking net = new networking();
                                            String ans = await net.post(context, "addcategory.php", data);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            if (ans == "") {
                                              Fluttertoast.showToast(msg: "failed to add category", backgroundColor: Colors.black);
                                            } else {
                                              print(ans);

                                              Map data = jsonDecode(ans);
                                              if (data["message"] == true) {
                                                Fluttertoast.showToast(msg:"category SUCCESSFULLY added", backgroundColor: Colors.black);
                                                if (data["role"] == "customer") {
                                                  Navigator.pushNamed(context, "/CustomerHome");
                                                } else if (data["role"] == "admin") {
                                                  Navigator.pushNamed(context, "/admin");
                                                } else if (data["role"] == "staff") {}
                                              } else {
                                                Fluttertoast.showToast(msg: "API error", backgroundColor: Colors.black);
                                              }
                                            }
                                          }else{

                                          }

                                        },
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(color: Colors.white, fontSize: 25),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              );
                            }),
                          ),
                        );
                      },



                      child: Card(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        //color: Color.fromRGBO(0, 0, 80, 0.8),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.add_box_outlined,
                                color: Colors.white,
                              ),
                              Divider(),
                              Text(
                                "Add Category",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),

                      ),
                    ),


                    GestureDetector(
                      onTap: (){
                        showDialog(
                          barrierLabel: "Register Category",
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            content: Builder(builder: (context) {
                              return Container(
                                height: 350,
                                child: Column(
                                  children: [
                                    Text("Add new Institution"),
                                    Divider(),
                                    Divider(),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15.0, top: 15, bottom: 10),
                                      //padding: EdgeInsets.symmetric(horizontal: 15),
                                      child: TextFormField(
                                        //autovalidateMode: AutovalidateMode.always,
                                        controller: contr,
                                        //obscureText: true,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            labelText: 'Institution name',
                                            hintText: 'name of Institution'),
                                        validator: (value) {
                                          if (value.toString().isEmpty) {
                                            return "Institution cannot be empty!";
                                          } else {
                                            dat = value.toString();
                                            //return value;
                                          }
                                        },
                                        onChanged: (value) {
                                          dat = value.toString();
                                        },
                                      ),
                                    ),

                                    Divider(),

                                    Container(
                                      height: 50,
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(20)),
                                      child: FlatButton(
                                        onPressed: () async {
                                          if(dat.isNotEmpty){
                                            Map data = {"instname" : dat};
                                            networking net = new networking();
                                            String ans = await net.post(context, "addcategory.php", data);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            if (ans == "") {
                                              Fluttertoast.showToast(msg: "failed to add category", backgroundColor: Colors.black);
                                            } else {
                                              print(ans);

                                              Map data = jsonDecode(ans);
                                              if (data["message"] == true) {
                                                Fluttertoast.showToast(msg:"category SUCCESSFULLY added", backgroundColor: Colors.black);
                                                if (data["role"] == "customer") {
                                                  Navigator.pushNamed(context, "/CustomerHome");
                                                } else if (data["role"] == "admin") {
                                                  Navigator.pushNamed(context, "/admin");
                                                } else if (data["role"] == "staff") {}
                                              } else {
                                                Fluttertoast.showToast(msg: "API error", backgroundColor: Colors.black);
                                              }
                                            }
                                          }else{

                                          }

                                        },
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(color: Colors.white, fontSize: 25),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              );
                            }),
                          ),
                        );
                      },



                      child: Card(
                        color: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        //color: Color.fromRGBO(0, 0, 80, 0.8),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.people,
                                color: Colors.white,
                              ),
                              Divider(),
                              Text(
                                "Add institution",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),

                      ),
                    ),


                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, "/tools");
                      },



                      child: Card(
                        color: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        //color: Color.fromRGBO(0, 0, 80, 0.8),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.people,
                                color: Colors.white,
                              ),
                              Divider(),
                              Text(
                                "Admin tools",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),

                      ),
                    ),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }





  // Widget iptiform() {
  // }




}
