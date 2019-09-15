import 'package:flutter/material.dart';

class SavedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/image.png'),
        // ...
      ),
      // ...
    ),
  ),
    );
  }
}
