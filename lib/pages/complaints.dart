import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DrawerMenu.dart';
import 'networking.dart';

class complaints extends StatefulWidget {
  const complaints({Key? key}) : super(key: key);

  @override
  _complaintsState createState() => _complaintsState();
}

class _complaintsState extends State<complaints> {
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
        case 2:
          iptisam = rejected(context);
          _selectedIndex = index;
          break;
      }
    });
  }

  Future<String> getcomplaints() async{
    sp = await SharedPreferences.getInstance();

    networking net = new networking();

    String ans = await net.get(context, "getCustomerComplaint.php?name="+sp.getString("name").toString());
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
      endDrawer: draw(context),
      bottomNavigationBar: BottomNavigationBar(
        //showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 5,
        selectedItemColor: Colors.blueAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.query_builder),
            label: "Sent :",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: "In-progress :",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.close_rounded),
            label: "solved :",
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
                "Sent Complaints :",
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

                  if (e['status'] == "sent"){
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

  Widget confirm(context){
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "in-progress Complaints :",
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

  Widget rejected(context){
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
