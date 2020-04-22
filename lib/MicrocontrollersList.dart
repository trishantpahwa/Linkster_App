import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class MicrocontrollersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMicrocontrollers(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...', style: TextStyle(fontSize: 35, color: Colors.deepOrange));
          default:
            return new ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {              
                return new Column(
                  children: <Widget>[
                    Text(snapshot.data[index]['Name'], style: TextStyle(fontSize: 30, color: Colors.deepOrange)),
                    Column(
                    children: [                    
                        for(String switchName in snapshot.data[index]['Switches'])
                        Column(children: <Widget>[
                          Text(switchName, style: TextStyle(fontSize: 20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            RaisedButton(child: Text('On'), onPressed: (){
                              switchOn(snapshot.data[index]['Name'], switchName);
                            }),
                            RaisedButton(child: Text('Off'), onPressed: (){
                              switchOff(snapshot.data[index]['Name'], switchName);
                            })
                          ],)
                        ])
                      ],
                    )
                  ]
                );             
            });
        }
      },
    );
  }
  switchOn(microControllerName, switchName) async {
    String uri = 'http://192.168.1.28:3000/Microcontroller/' + microControllerName + '/Switch/' + switchName + '/on';
    final prefs = await SharedPreferences.getInstance();
    final key = 'Token';
    final value = prefs.getString(key);
    var response = await http.get(uri, headers: {"Token": value});
    if(response.statusCode == 200) {
      print(switchName + ' switched on.');
    } else {
      print(response.statusCode);
      print('Error');
    }
  }
  switchOff(microControllerName, switchName) async {
    String uri = 'http://192.168.1.28:3000/Microcontroller/' + microControllerName + '/Switch/' + switchName + '/off';
    final prefs = await SharedPreferences.getInstance();
    final key = 'Token';
    final value = prefs.getString(key);
    var response = await http.get(uri, headers: {"Token": value});
    if(response.statusCode == 200) {
      print(switchName + ' switched off.');
    } else {
      print(response.statusCode);
      print('Error');
    }
  }
  getMicrocontrollers() async {
    String uri = 'http://192.168.1.28:3000/Microcontroller';
    var Microcontrollers = [];
    final prefs = await SharedPreferences.getInstance();
    final key = 'Token';
    final value = prefs.getString(key);
    var response = await http.get(uri, headers: {"Token": value});
    if(response.statusCode == 200) {
      var microcontrollers = json.decode(response.body)['Microcontrollers'];
      for(var i=0;i<microcontrollers.length;i++) {
        String uri1 = 'http://192.168.1.28:3000/Microcontroller/' + microcontrollers[i] + '/switches';
        var response1 = await http.get(uri1, headers: {"Token": value});
        if(response1.statusCode == 200) {
          var switches = json.decode(response1.body)[microcontrollers[i]];
          var Microcontroller = {'Name': microcontrollers[i], 'Switches': switches};
          Microcontrollers.add(Microcontroller);
        }
      }
    }  
    return Microcontrollers;
  }
}