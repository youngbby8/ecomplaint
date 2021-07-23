import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DrawerMenu.dart';
import 'networking.dart';

enum ComplaintCategory { Survey, Meter, Service, Others }

class ComplaintForm extends StatefulWidget {
  const ComplaintForm({Key? key}) : super(key: key);

  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  String instvalue = "";
  String catvalue = "";
  List inst = [];
  List cate = [];
  String address = "";
  String desc = "";
  bool have = false;
  late Map abc;
  late SharedPreferences sp;

  ComplaintCategory compcat = ComplaintCategory.Survey;

  Future<String> set() async{
    sp = await SharedPreferences.getInstance();
    return sp.getString("name").toString();
  }

  Future<String> getvalue(context) async{
    networking net = new networking();
    String ans = await net.get(context, "tools.php");
    if (ans == "") {
      Fluttertoast.showToast(msg: "error fetching categories and institutions");
      return "";
    } else {
      print(ans);
      Map data = jsonDecode(ans);
      if (data["message"] == true) {
        inst = data['inst'];
        cate = data['cat'];

        instvalue = instvalue == "" ? inst[0] : instvalue;
        catvalue = catvalue == "" ? cate[0] : catvalue;

        print(data);
        return "yeeeey";
      } else {
        Fluttertoast.showToast(msg: "API ERROR", backgroundColor: Colors.black);
        return "";
      }
    }



  }

  @override
  void initState() {
    // TODO: implement initState
    set();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Make Comlaint",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        endDrawer: draw(context),
        body: FutureBuilder(
          future: getvalue(context),
          initialData: "fetching categories and institutions",
          builder: (BuildContext context, AsyncSnapshot<String> text){
            return ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "Complaint Form",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30
                        ),
                      ),
                      Divider(),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                                "Customer Name :"
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: FutureBuilder(
                              future: set(),
                              builder: (BuildContext context, AsyncSnapshot<String> T){
                                return Text(
                                  "${sp.getString('name')}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Divider(),

                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                                'Select Institute'
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: DropdownButton(
                                isExpanded: true,
                                //value: "$instvalue",
                                items: inst.map((e) {
                                  return DropdownMenuItem(
                                    child: Text("$e"),
                                    value: e,
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  print(val);

                                  setState(() {
                                    instvalue = val.toString();
                                  });
                                },
                                hint: Text("$instvalue")),
                          ),
                        ],
                      ),

                      Divider(),
                      Divider(),

                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                                'Complaint category'
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: DropdownButton(
                                isExpanded: true,
                                //value: "$catvalue",
                                items: cate.map((e) {
                                  return DropdownMenuItem(
                                    child: Text("$e"),
                                    value: e,
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  print(val);

                                  setState(() {
                                    catvalue = val.toString();
                                  });
                                },
                                hint: Text("$catvalue")),
                          ),
                        ],
                      ),

                      Divider(),
                      Divider(),

                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                                'Complaint Address'
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: TextFormField(
                              //autovalidateMode: AutovalidateMode.always,
                              //controller: _password,
                              //obscureText: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: 'Address',
                                  hintText: 'where you are from'),
                              onChanged: (value) {
                                address = value.toString();
                              },
                            ),
                          ),
                        ],
                      ),

                      Divider(),
                      Divider(),

                      Text(
                        "Write a short description about your complaint",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(),
                      TextFormField(
                        maxLines: 5,
                        //autovalidateMode: AutovalidateMode.always,
                        //controller: _password,
                        //obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText: 'complaint description',
                            hintText: 'Write a short description about your complaint'),
                        onChanged: (value) {
                          desc = value.toString();
                        },
                      ),

                      Divider(),
                      Divider(),

                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.blueGrey
                          ),
                          child: Center(
                            child: Text(
                              'Make Complaint',
                              style: TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ),

                        onTap: () async {
                          Map d = {
                            "Institution" : instvalue,
                            "Category" : catvalue,
                            "Comp_address" : address,
                            "Description" : desc,
                            "name" : sp.getString("name").toString(),
                          };

                          networking net = new networking();
                          String ans = await net.post(context, "complaintForm.php", d);

                          if (ans == "") {
                            Fluttertoast.showToast(
                                msg: "error in making a complaint");
                          } else {
                            print(ans);
                            Map a = jsonDecode(ans);
                            if(a['message'] == true){
                              Fluttertoast.showToast(
                                  msg: "complaint made successfuly", backgroundColor: Colors.black);
                              Navigator.pushNamed(context, '/customerComplaint');
                            }else{
                              Fluttertoast.showToast(
                                  msg: "failed to make a complaint", backgroundColor: Colors.black);
                            }
                          }
                        },
                      ),


                    ],
                  ),
                ),
              ],
            );
          },
        )
    );
  }
}
