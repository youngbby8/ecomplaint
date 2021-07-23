
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'networking.dart';

class tools extends StatefulWidget {
  const tools({Key? key}) : super(key: key);

  @override
  _toolsState createState() => _toolsState();
}

class _toolsState extends State<tools> {

  int _selectedIndex = 0;
  Widget abc = Container();
  List iptisam =[];
  List users = [];
  List category = [];
  List insti = [];
  late SharedPreferences sp;

  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          iptisam = users;
          abc = userview();
          _selectedIndex = index;
          break;
        case 1:
          iptisam = category;
          abc = categoryview();
          _selectedIndex = index;
          break;
        case 2:
          iptisam = insti;
          abc = institution();
          _selectedIndex = index;
          break;
      }
    });
  }

  Future<String> getcomplaints() async{
    sp = await SharedPreferences.getInstance();

    networking net = new networking();

    String ans = await net.get(context, "admintools.php");

    if (ans == "") {
      Fluttertoast.showToast(msg: "error fetching complaints");
      return "";
    } else {
      print(ans);
      //Fluttertoast.showToast(msg: "$ans");
      Map data = jsonDecode(ans);
      if (data["message"] == true) {
        category = data['cat'];
        insti = data['inst'];
        users = data['users'];
      } else {
        // Fluttertoast.showToast(msg: "API ERROR", backgroundColor: Colors.black);
        // return "";
      }
    }
    return "";
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      bottomNavigationBar: BottomNavigationBar(
        //showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 5,
        selectedItemColor: Colors.blueAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_rounded),
            label: "Users",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.house_siding_sharp),
            label: "Institution",
          ),
        ],
      ),

      body: FutureBuilder(
        future: getcomplaints(),
        initialData: "loading complaints",
        builder: (BuildContext context, AsyncSnapshot<String> text){
          return abc;
        },
      ),
    );
  }


  Widget userview(){
    return Container(
      padding:  EdgeInsets.all(20),
      child: ListView(
        children: iptisam.map((e) {
          return Card(
            child: ListTile(
              onTap: (){
                deldata("e_login", e['id'], e['full_name']);
              },
              leading: Icon(Icons.account_circle_outlined),
              trailing: Icon(Icons.delete),
              title: Text(
                "${e['full_name']}",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget categoryview(){
    return Container(
      padding:  EdgeInsets.all(20),
      child: ListView(
        children: iptisam.map((e) {
          return Card(
            child: ListTile(
              onTap: (){
                deldata("e_category", e['id'], e['cat_name']);
              },
              leading: Icon(Icons.calendar_today_outlined),
              trailing: Icon(Icons.delete),
              title: Text(
                "${e['cat_name']}",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget institution(){
    return Container(
      padding:  EdgeInsets.all(20),
      child: ListView(
        children: iptisam.map((e) {
          return Card(
            child: ListTile(
              onTap: (){
                deldata("e_institution", e['id'], e['instname']);
              },
              leading: Icon(Icons.house_siding_outlined),
              trailing: Icon(Icons.delete),
              title: Text(
                "${e['instname']}",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }



  void deldata(String table, String id, String name){
    showDialog(
      barrierLabel: "",
      context: context,
      builder: (BuildContext context) => AlertDialog(
        scrollable: true,
        content: Builder(builder: (context) {
          return Container(
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Delete $name ?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Divider(),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.blueGrey,
                          child: Center(
                            child: Text(
                              "No",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(),
                    Expanded(
                      child: GestureDetector(
                        child: Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.redAccent,
                            child: Center(
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () async{

                          networking net = new networking();

                          Map data = {
                            "id" : id,
                            "table" : table
                          };

                          String ans = await net.post(context, "delete.php", data);

                          if (ans == "") {
                            Fluttertoast.showToast(msg: "error deleting $name");
                          } else {
                            print(" deleated! "+ ans);
                            Map data = jsonDecode(ans);
                            if (data["message"] == true) {
                              Navigator.pop(context);
                              Fluttertoast.showToast(msg: "$name successfully deleted");

                              setState(() {

                              });
                            } else {
                              Fluttertoast.showToast(msg: "API ERROR failed to delete $name", backgroundColor: Colors.black);
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
        }),
      ),
    );
  }
}
