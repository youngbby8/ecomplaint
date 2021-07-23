import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class networking{

  String url = "http://10.0.2.2/ecomplains1API/" ;
  late http.Response res;

  void nvitu(context){
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Builder(builder: (context) {
          return Container(
            child: Text("loading..."),
          );
        }),
      ),
    );
  }

  Future<String> post(context, String route, Map data) async{
    nvitu(context);
    res = await http.post(Uri.parse(url+route), body: data).whenComplete(() {
      Navigator.maybePop(context);
    });

    if(res.body.isNotEmpty){
      return res.body;
    }else{
      Fluttertoast.showToast(msg: "error connecting");
      return "";
    }

  }

  Future<String> get(context, ur) async{
    //nvitu(context);
    res = await http.get(Uri.parse(url+ur)).whenComplete(() {
      //Navigator.maybePop(context);
    });

    if(res.body.isNotEmpty){
      return res.body;
    }else{
      Fluttertoast.showToast(msg: "error connecting");
      return "";
    }

  }


}