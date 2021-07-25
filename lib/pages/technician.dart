import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DrawerMenu.dart';
import 'networking.dart';

class technician extends StatefulWidget {
  const technician({Key? key}) : super(key: key);

  @override
  _technicianState createState() => _technicianState();
}

class _technicianState extends State<technician> {

  bool have = false;
  late Map abc;

  Future<String> getinfo(context) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String email = sp.getString("email").toString();
    networking net = new networking();
    String ans = await net.get(context, "getinfo.php?email="+email);
    if (ans == "") {
      Fluttertoast.showToast(msg: "error in getting data");
      return "";
    } else {
      print(ans);
      Map data = jsonDecode(ans);
      if (data["message"] == true) {
        have = true;
        abc = data["data"];
        return "yeeeey";
      } else {
        Fluttertoast.showToast(msg: "API ERROR", backgroundColor: Colors.black);
        return "";
      }
    }

    return "";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Technician",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      endDrawer: techdrawer(context),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 3,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage(
                    "picha/account1.jpg"
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Card(
                color: Colors.white38,
                elevation: 10.0,
                child: Container(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    width: 400,
                    height: 600,
                    child: Column(
                      children: [
                        Text(
                          "STAFF'S INFORMATION",
                          style: TextStyle(fontSize: 25),
                        ),
                        Card(
                          color: Colors.white,
                          child: SizedBox(
                            width: 300,
                            height: 300,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Divider(),
                                            Align(alignment: Alignment.centerLeft,child: Text("NAME:")),
                                            Divider(),
                                            Align(alignment: Alignment.centerLeft,child: Text("USERNAME:")),
                                            Divider(),
                                            Align(alignment: Alignment.centerLeft,child: Text("USERTYPE:")),
                                            Divider(),
                                            Align(alignment: Alignment.centerLeft,child: Text("ADDRESS:")),
                                            Divider(color: Colors.white,),
                                            Divider(),
                                            Align(alignment: Alignment.centerLeft,child: Text("PHONE NUMBER:")),
                                          ],
                                        ),
                                      ),
                                      VerticalDivider(),
                                      Expanded(
                                        child: FutureBuilder(
                                          future: getinfo(context),
                                          initialData: "loading please wait",
                                          builder: (BuildContext context, AsyncSnapshot<String> text){
                                            //Navigator.maybePop(context);
                                            return have ? new Column(
                                              children: [
                                                Divider(),
                                                Align(alignment: Alignment.centerLeft,child: Text("${abc["full_name"]}")),
                                                Divider(),
                                                Align(alignment: Alignment.centerLeft,child: Text("${abc["email"]}")),
                                                Divider(),
                                                Align(alignment: Alignment.centerLeft,child: Text("${abc["role"]}")),
                                                Divider(),
                                                Align(alignment: Alignment.centerLeft,child: Text("${abc["address"]}")),
                                                Divider(color: Colors.white,),
                                                Divider(),
                                                Align(alignment: Alignment.centerLeft,child: Text("${abc["phone_no"]}")),
                                              ],
                                            ) :
                                            new Column(
                                              children: [
                                                Divider(),
                                                Text("__________"),
                                                Divider(),
                                                Text("__________"),
                                                Divider(),
                                                Text("__________"),
                                                Divider(),
                                                Text("__________"),
                                                Divider(),
                                                Text("__________"),
                                              ],
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
