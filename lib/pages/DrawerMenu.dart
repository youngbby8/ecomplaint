import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Drawer draw(context){
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("Iptisam Fum Khamis"),
          accountEmail: Text("iptisamkhamis@gmail.com"),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              "IK",
              style: TextStyle(fontSize: 40.0),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Home"),
          onTap: () {
            Navigator.pushNamed(context, '/CustomerHome');
          },
        ),
        ListTile(
          leading: Icon(Icons.message_outlined),
          title: Text("Make Complaints"),
          onTap: () {
            Navigator.pushNamed(context, '/ComplaintForm');
          }
        ),
        ListTile(
          leading: Icon(Icons.email_outlined),
          title: Text("View Complaints"),
          onTap: () {
            Navigator.pushNamed(context, '/customerComplaint');
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app_outlined),
          title: Text("Logout"),
          onTap: () async{
            SharedPreferences sp = await SharedPreferences.getInstance();

            sp.setBool("is_logged", false);
            sp.setString("email", "");
            sp.setString("location", "");
            Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);

          },
        ),
      ],
    ),
  );
}


Drawer staffdrawer(context){
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("Iptisam Fum Khamis"),
          accountEmail: Text("iptisamkhamis@gmail.com"),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              "Sf",
              style: TextStyle(fontSize: 40.0),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Home"),
          onTap: () {
            Navigator.pushNamed(context, '/staff');
          },
        ),
        ListTile(
            leading: Icon(Icons.message_outlined),
            title: Text("Complaints"),
            onTap: () {
              Navigator.pushNamed(context, '/staffcomplaints');
            }
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app_outlined),
          title: Text("Logout"),
          onTap: () async{
            SharedPreferences sp = await SharedPreferences.getInstance();

            sp.setBool("is_logged", false);
            sp.setString("email", "");
            sp.setString("location", "");
            Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);

          },
        ),
      ],
    ),
  );
}


Drawer techdrawer(context){
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("Iptisam Fum Khamis"),
          accountEmail: Text("iptisamkhamis@gmail.com"),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              "Sf",
              style: TextStyle(fontSize: 40.0),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Home"),
          onTap: () {
            Navigator.pushNamed(context, '/technician');
          },
        ),
        ListTile(
            leading: Icon(Icons.message_outlined),
            title: Text("Complaints"),
            onTap: () {
              Navigator.pushNamed(context, '/techcomplaint');
            }
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app_outlined),
          title: Text("Logout"),
          onTap: () async{
            SharedPreferences sp = await SharedPreferences.getInstance();

            sp.setBool("is_logged", false);
            sp.setString("email", "");
            sp.setString("location", "");
            Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);

          },
        ),
      ],
    ),
  );
}