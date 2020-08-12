import 'package:flutter/material.dart';
import 'cores/cores.dart';
// import 'week1/week1.dart';
import 'week2/week2.dart';

void main() {
  runApp(
    MaterialApp(
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/pilih': (BuildContext context) => PilihPage(),
        '/login': (BuildContext context) => Login(),
        '/kalkulator': (BuildContext context) => Kalkulator(),
        '/bmi': (BuildContext context) => HomeBMI(),
      },
    ),
  );
}
