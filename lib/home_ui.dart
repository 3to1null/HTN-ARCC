import 'package:flutter/material.dart';

class BottomUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10.0,
      left: 0.0,
      right: 0.0,
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(color: Colors.green),
          )
        ],
      ),
    );
  }
}