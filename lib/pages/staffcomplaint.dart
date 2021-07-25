import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DrawerMenu.dart';
import 'networking.dart';

class staffcomplaint extends StatefulWidget {
  const staffcomplaint({Key? key}) : super(key: key);

  @override
  _staffcomplaintState createState() => _staffcomplaintState();
}

class _staffcomplaintState extends State<staffcomplaint> {
  String val = "sent";
  List tecs = [];
  List compp = [];
  late SharedPreferences sp;

  Future<String> getcomplaints() async{
    sp = await SharedPreferences.getInstance();

    networking net = new networking();

    String ans = await net.get(context, "getAllComplaints.php?name="+sp.getString("name").toString());
    print("going to getCustomerComplaint.php?name="+sp.getString("name").toString());

    if (ans == "") {
      Fluttertoast.showToast(msg: "error fetching complaints");
      return "";
    } else {
      print(ans);
      Map data = jsonDecode(ans);
      if (data["message"] == true) {
        compp = data['complaints'];
        print(data);
        return "yeeeey";
      } else {
        Fluttertoast.showToast(msg: "API ERROR", backgroundColor: Colors.black);
        return "";
      }
    }
    return "";
  }

  Future<String> gettec() async{
    networking net = new networking();
    String ans = await net.get(context, "gettech.php");
    print("going to get technicians");

    if (ans == "") {
      tecs =[];
      return "error fetching technicians";
    } else {
      print(ans);
      Map data = jsonDecode(ans);
      if (data["message"] == true) {
        tecs = data['user'];
        return "";

      } else {
        return "";
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tecs = [];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Call Center",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      endDrawer: staffdrawer(context),
      body: FutureBuilder(
        future: getcomplaints(),
        initialData: "loading complaints",
        builder: (BuildContext context, AsyncSnapshot<String> text){
          return comps(context);
        },
      ),
    );
  }

  Widget comps(context){
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButton(
                      isExpanded: true,
                      onChanged: (value){
                        compp = [];
                        setState(() {
                          val = value.toString();
                        });
                      },
                      hint: Text("choose type"),
                      value: val,
                      items: [
                        DropdownMenuItem(
                          value: "sent",
                          child: Text(
                            "sent"
                          )
                        ),
                        DropdownMenuItem(
                            value: "in-progress",
                            child: Text(
                                "in-progress"
                            )
                        ),
                        DropdownMenuItem(
                            value: "solved",
                            child: Text(
                                "solved"
                            )
                        ),
                      ],

                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Complaints ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: compp.map((e){

                  if(e['status'] == val){
                    return card(e);
                  }else{
                    return Container();
                  }
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );

  }

  Widget card(var e){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),

      ),
      //color: Color.fromRGBO(0, 0, 80, 0.8),
      child:ListTile(
        title: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          child: Text(
            "${e['customer']}, ${e['comp_address']}",
            style: TextStyle(
                fontStyle: FontStyle.italic
            ),

          ),
        ),
        leading: Text(
          "${e['institution']}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),

        ),
        trailing: e['status'] != "sent" ? Text("${e['status']}") : ElevatedButton(
          child: Text(
              "Assign"
          ),
          onPressed: () async{
            await gettec().then((value) {
              Widget abc = tecs.isEmpty ? Center(child: Text("hello"),) : ListView(
                children: tecs.map((e) {
                  return Text("$e");
                }).toList(),
              );

              showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      scrollable: true,
                      content: Builder(
                          builder: (BuildContext context) {
                            return Container(
                              color: Colors.white,
                              child: Column(
                                children: tecs.map((f) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Icon(EvaIcons.person),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: ElevatedButton(
                                          child: Text(
                                              "${f['full_name']}"
                                          ),
                                          onPressed: () async{
                                            networking net = new networking();

                                            String ans = await net.post(context, "changestatus.php", {"id" : e['comp_id'].toString(), "status" : "in-progress", "to": f['full_name'].toString()});
                                            print("going to changestatus.php?");
                                            if (ans == "") {
                                              Fluttertoast.showToast(msg: "failed to assign complaint to ${f['full_name']}");

                                            } else {
                                              print(ans);
                                              Map data = jsonDecode(ans);
                                              if (data["message"] == true) {
                                                Fluttertoast.showToast(msg: "complaint assignd to ${f['full_name']}");
                                                Navigator.pushNamed(context, "/staffcomplaint");
                                              } else {
                                                Fluttertoast.showToast(msg: "API ERROR", backgroundColor: Colors.black);
                                              }
                                            }
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            );
                          }
                      ),
                    );
                  }
              );


            });
          },
        ),
        onTap: (){
          showDialog(
            context: context,
            builder: (contex){
              return AlertDialog(
                scrollable: true,
                content: StatefulBuilder(
                    builder: (context, setState){
                  return Container(
                    child: Column(
                      children: [
                        Text(
                          "Description :",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),

                        ),
                        Divider(color: Colors.white),
                        Text(
                          "${e['description']}",
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                          ),

                        ),
                        Divider(color: Colors.white),
                        Divider(color: Colors.white),
                        Divider(color: Colors.white),
                        Text(
                          "From",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),

                        ),
                        Divider(color: Colors.white),
                        Text(
                          "${e['customer']} - ${e['comp_address']}",
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                          ),

                        ),
                        Divider(color: Colors.white),
                        Divider(color: Colors.white),
                        Divider(color: Colors.white),
                        Text(
                          "Submitted on",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),

                        ),
                        Divider(color: Colors.white),
                        Text(
                          "${e['date']}",
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                          ),

                        ),
                      ],
                    ),
                  );
                  }
                ),
              );
            }
          );
        },
      ),

    );
  }



}
