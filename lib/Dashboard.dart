import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:linkster_app/MicrocontrollersList.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
              logout();
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
  logout() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'Token';
    final value = null;
    prefs.setString(key, value);
  }
}