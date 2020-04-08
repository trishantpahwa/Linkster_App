import 'package:flutter/material.dart';
import './CustomInputField.dart';

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
  login(username, password) {
    print(username.text);
    print(password.text);
  }
}