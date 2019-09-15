import 'package:flutter/material.dart';
import 'history.dart';
import 'calculator.dart';

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
            _historyButton(context),
            _camButton(),
            _calculatorButton(context),
          ],
        ),
      ),
    );
  }

  Widget _historyButton(BuildContext context) => IconButton(
        icon: Icon(
          Icons.history,
          color: Colors.white,
          size: 35,
        ),
        onPressed: () {
          print("object");
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => HistoryPage()));
        },
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
        fillColor: Color(0xFF1CD0A2),
        padding: const EdgeInsets.all(35.0),
      );

  _calculatorButton(context) => IconButton(
        icon: Icon(
          Icons.equalizer,
          color: Colors.white,
          size: 35,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => Calculator()));
        },
      );
}
