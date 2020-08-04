import 'package:flutter/material.dart';

class HasilBMI extends StatelessWidget {
  final double bmi;
  HasilBMI(this.bmi);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.blue,
      child: Text('$bmi'),
    );
  }
}
