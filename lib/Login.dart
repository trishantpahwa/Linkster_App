import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './CustomInputField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

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
                CustomInputField(Icon(Icons.person, color: Colors.white), 'Username', false, usernameController),
                SizedBox(height: 13),
                CustomInputField(Icon(Icons.lock, color: Colors.white), 'Password', true, passwordController),
                SizedBox(height: 10),
                Container(
                  width: 150,
                  child: RaisedButton(
                    onPressed: () {login(usernameController, passwordController);},
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
  login(username, password) async {
    String uri = 'http://192.168.1.28:3000/User/' + username.text + '/login';
    var response = await http.post(uri, body: {"Password": password.text});
    final prefs = await SharedPreferences.getInstance();
    final key = 'Token';
    final value = json.decode(response.body)['Token'];
    prefs.setString(key, value);
  }
}