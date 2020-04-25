import 'package:flutter/material.dart';
import './Login.dart';
import 'package:linkster_app/MicrocontrollersList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Linkster'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: (){
              logout(context);
            },
          )
        ]
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: Center(
          child: Container(
            child: MicrocontrollersList()
          )
        )
      )
    );  
  }
  logout(context) async {
    String uri = 'http://192.168.1.28:3000/User/logout';
    final prefs = await SharedPreferences.getInstance();
    final key = 'Token';
    var value = prefs.getString(key);
    var response = await http.get(uri, headers: {"Token": value});
    if(response.statusCode == 200) {
      value = null;
      prefs.setString(key, value);
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (BuildContext context){
            return new Login();
          }
        )
      );
    } else {
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (BuildContext context){
            return new Dashboard();
          }
        )
      );
    }
  }
}