import 'package:flutter/material.dart';

class HomeButtonsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _historyButton(),
            _camButton(),
            _calculatorButton(),
          ],
        ),
      ),
    );
  }

  _historyButton() => IconButton(
        icon: Icon(
          Icons.history,
          color: Colors.white,
          size: 35,
        ),
        onPressed: () {},
      );
  _camButton() => RawMaterialButton(
        onPressed: () {},
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.white,
            width: 3,
          ),
        ),
        elevation: 2.0,
        fillColor: Colors.green,
        padding: const EdgeInsets.all(35.0),
      );

  _calculatorButton() => IconButton(
        icon: Icon(
          Icons.equalizer,
          color: Colors.white,
          size: 35,
        ),
        onPressed: () {},
      );
}
