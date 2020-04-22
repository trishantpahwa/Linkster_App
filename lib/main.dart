import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './Dashboard.dart';
import './Login.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linkster',
      home: HomeScreen()
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkLogin(),
      builder: (BuildContext context, AsyncSnapshot snapshot){      
        var value = snapshot.data;
        if(value == null) {
          return Login();
        } else {
          return Dashboard();
        }
      }
    );
  }
  checkLogin() async {
    var prefs = await SharedPreferences.getInstance();
    final key = 'Token';
    final value = prefs.getString(key);
    print(value);
    return value;
  }
}