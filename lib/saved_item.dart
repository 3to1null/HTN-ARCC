import 'package:flutter/material.dart';

class SavedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image from assets"),
        ),
        body: Image.asset('assets/images/lake.jpg'), //   <--- image here
    );
  }
}
