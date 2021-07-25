import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DrawerMenu.dart';
import 'networking.dart';

class techcomplaint extends StatefulWidget {
  const techcomplaint({Key? key}) : super(key: key);

  @override
  _techcomplaintState createState() => _techcomplaintState();
}

class _techcomplaintState extends State<techcomplaint> {
  int _selectedIndex = 0;
  late Widget iptisam ;
  List comps = [];
  late SharedPreferences sp;

  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          iptisam = pending(context);
          _selectedIndex = index;
          break;
        case 1:
          iptisam = confirm(context);
          _selectedIndex = index;
          break;
      }
    });
  }

  Future<String> getcomplaints() async{
    sp = await SharedPreferences.getInstance();

    networking net = new networking();

    String ans = await net.get(context, "getTechComplaint.php?name="+sp.getString("name").toString());
    print("going to getCustomerComplaint.php?name="+sp.getString("name").toString());

    if (ans == "") {
      Fluttertoast.showToast(msg: "error fetching complaints");
      return "";
    } else {
      print(ans);
      Map data = jsonDecode(ans);
      if (data["message"] == true) {
        comps = data['complaints'];
        print(data);
        return "yeeeey";
      } else {
        Fluttertoast.showToast(msg: "API ERROR", backgroundColor: Colors.black);
        return "";
      }
    }
    return "";
  }

  @override
  void initState() {
    // TODO: implement initState
    //iptisam = pending(context);
    super.initState();
    comps = [];
    iptisam = pending(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "View Your Comlaints",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      endDrawer: techdrawer(context),
      bottomNavigationBar: BottomNavigationBar(
        //showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 5,
        selectedItemColor: Colors.blueAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.query_builder),
            label: "Pending :",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: "Solved :",
          ),
        ],
      ),

      body: FutureBuilder(
        future: getcomplaints(),
        initialData: "loading complaints",
        builder: (BuildContext context, AsyncSnapshot<String> text){
          return iptisam;
        },
      ),
    );
  }


  Widget pending(context){
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "Pending Complaints :",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: comps.map((e){

                  if (e['status'] == "in-progress"){
                    return  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),

                      ),
                      //color: Color.fromRGBO(0, 0, 80, 0.8),
                      child:ListTile(
                        title: Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Text(
                            "${e['category']}",
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
                        trailing: ElevatedButton(
                          child: Text(
                              "SOLVED ?"
                          ),
                          onPressed: () async{
                            networking net = new networking();

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
                                              children: [

                                                Center(
                                                  child: Text(
                                                    "Please Confirm",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 25
                                                    )
                                                  ),
                                                ),

                                                Divider(),

                                                Text(
                                                    "are you sure you have solved the complaint ?"
                                                ),

                                                Divider(),

                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        child: Text("no"),
                                                        onPressed: (){
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                    ),
                                                    VerticalDivider(),
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        child: Text("yes"),
                                                        onPressed: () async{
                                                          String ans = await net.post(context, "changestatus.php", {"id" : e['comp_id'].toString(), "status" : "solved"});
                                                          print("going to changestatus.php?");
                                                          if (ans == "") {
                                                            Fluttertoast.showToast(msg: "failed to set complaint as solved");

                                                          } else {
                                                            print(ans);
                                                            Map data = jsonDecode(ans);
                                                            if (data["message"] == true) {
                                                              Navigator.pop(context);
                                                              Fluttertoast.showToast(msg: "complaint set to SOLVED!");
                                                              Navigator.pushNamed(context, "/techcomplaint");
                                                            } else {
                                                              Fluttertoast.showToast(msg: "API ERROR", backgroundColor: Colors.black);
                                                            }
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
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
                        onTap: (){
                          studialog(e);
                        },
                      ),

                    );
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

  Widget confirm(context){
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "Solved Complaints :",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: comps.map((e){

                  if (e['status'] == "solved"){
                    return  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),

                      ),
                      //color: Color.fromRGBO(0, 0, 80, 0.8),
                      child:ListTile(
                        title: Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Text(
                            "${e['category']}",
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
                        trailing: Text(
                            "${e['status']}"
                        ),
                        onTap: (){
                          studialog(e);
                        },
                      ),

                    );
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


  void studialog(e){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: Row(
            children: [
              Text(
                "${e['customer']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              VerticalDivider(color: Colors.grey),
              Icon(Icons.account_circle_outlined)

            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                          "Institution :"
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Text(
                        "${e['institution']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
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
                          "Category :"
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Text(
                        "${e['category']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
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
                          "complaint date :"
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Text(
                        "${e['date']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
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
                          "status :"
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Text(
                        "${e['status']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
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
                          "customer address :"
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Text(
                        "${e['comp_address']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Divider(),

                Text("${e['description']}")


              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                  'Close'
              ),
              onPressed: (){
                setState(
                        (){
                      Navigator.of(context).pop();
                    }
                );
              },
            ),
          ],
        );
      },
    );
  }
}
