import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  
  Icon fieldIcon;
  String hintText;
  bool secureText;
  TextEditingController controller;

  CustomInputField(this.fieldIcon, this.hintText, this.secureText, this.controller);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.deepOrange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: fieldIcon
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3.0))
              ),
              width: 200,
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3.0))),
                    fillColor: Colors.white,
                    filled: true
                  ),
                  obscureText: secureText,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                  )
                )
              )
            )
          ],
        )
      )
    );
  }
}