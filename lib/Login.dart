import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import './CustomInputField.dart';
import './Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController localUriController = new TextEditingController();
  final TextEditingController remoteUriController = new TextEditingController();
  final TextEditingController wifiController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Linkster')
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: Center(
          child: Container(
            width: 400,
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomInputField(Icon(Icons.person, color: Colors.white, size: 20), 'Username', false, usernameController),
                SizedBox(height: 10),
                CustomInputField(Icon(Icons.lock, color: Colors.white, size: 20), 'Password', true, passwordController),
                SizedBox(height: 10),
                CustomInputField(Icon(Icons.link, color: Colors.white, size: 20), 'Local URL', false, localUriController),
                SizedBox(height: 10),
                CustomInputField(Icon(Icons.link_off, color: Colors.white, size: 20), 'Remote URL', false, remoteUriController),
                SizedBox(height: 10),
                CustomInputField(Icon(Icons.network_check, color: Colors.white, size: 20), 'Wi-Fi', false, wifiController),
                SizedBox(height: 10),
                Container(
                  width: 150,
                  child: RaisedButton(
                    onPressed: () {
                      //saveData(localUriController, remoteUriController, wifiController);
                      login(context, usernameController, passwordController);
                    },
                    color: Colors.deepOrange,
                    child: Text('Login', style: TextStyle(fontSize: 20.0, color: Colors.white))
                  )
                )
              ],
            )
          )
        )
      )
    );
  }
  // saveData(localUri, remoteUri, wifi) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final localUriKey = 'LocalURI';
  //   final localUriValue = localUri.text;
  //   prefs.setString(localUriKey, localUriValue);
  //   final remoteUriKey = 'RemoteUri';
  //   final remoteUriValue = remoteUri.text;
  //   prefs.setString(remoteUriKey, remoteUriValue);
  //   final wifiKey = 'wifiSSID';
  //   final wifiValue = wifi.text;
  //   prefs.setString(wifiKey, wifiValue);
  // }
  login(context, username, password) async {
    String uri = 'http://192.168.1.28:3000/User/' + username.text + '/login';
    var response = await http.post(uri, body: {"Password": password.text});
    if(response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      final key = 'Token';
      final value = json.decode(response.body)['Token'];
      prefs.setString(key, value);
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (BuildContext context){
            return new Dashboard();
          }
        )
      );
    } else {
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (BuildContext context){
            return new Login();
          }
        )
      );
    }
  }
}