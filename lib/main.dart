import 'package:flutter/material.dart';
import 'package:udacoding_bootcamp/bmi_calculator/home_bmi.dart';
import 'cores/cores.dart';
import 'week1/week1.dart';


void main() {
  runApp(
    MaterialApp(
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => Login(),
        '/bmi' : (BuildContext context) => HomeBMI(),
      },
    ),
  );
}

/*
void main() {
  runApp(
    MaterialApp(
      home: Login(),
    ),
  );
}
*/
