// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BWidget extends StatelessWidget {
  var btnText ="";
  var onClick;


  BWidget({this.btnText, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        splashColor: Colors.white,
        onTap: onClick,
        
        child: Container(
          width: 200,
          height: 65,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(95, 2, 52, 110), Color.fromARGB(95, 2, 52, 110)],
                end: Alignment.centerLeft,
                begin: Alignment.centerRight),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(1.5),
            width: 200,
            height: 65,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.white],
                  end: Alignment.centerLeft,
                  begin: Alignment.centerRight),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              btnText,
              style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 1, 64, 100),
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ),
    );
  }
}
