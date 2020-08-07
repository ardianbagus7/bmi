import 'package:flutter/material.dart';
import 'cores/cores.dart';
import 'week2/week2.dart';


void main() {
  runApp(
    MaterialApp(
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => Login(),
      },
    ),
  );
}
