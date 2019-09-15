import 'package:flutter/material.dart';
import 'charts.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final currencyStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20);
  final TextEditingController inputController = TextEditingController();
  final valueStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w200, fontSize: 50);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final _appBar = AppBar(
      backgroundColor: Colors.teal,
      centerTitle: true,
      title: Text(
        "Calculate Currency",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );

    final _cardShadow = <BoxShadow>[
      BoxShadow(
        color: Colors.black54,
        blurRadius: 10.0, // has the effect of softening the shadow
        spreadRadius: 0.2, // has the effect of extending the shadow
        offset: Offset(
          2.5, // horizontal, move right 10
          2.5, // vertical, move down 10
        ),
      )
    ];

    final _cardDeco = BoxDecoration(
      boxShadow: _cardShadow,
      borderRadius: BorderRadius.all(Radius.circular(50)),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF00FF9C), Color(0xFF1CD0A2)],
      ),
    );

    return Scaffold(
      appBar: _appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            padding: EdgeInsets.all(15),
            decoration: _cardDeco,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildCurrency1Widgets(),
                _buildArrowIcon(),
                _buildCurrency2Widgets(),
              ],
            ),
          ),

          RatesChart(),
        ],
      ),
    );
  }

  _buildInputField() => TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        controller: inputController,
        onSubmitted: (String amnt) {
          inputController.text = amnt;
          // * Do your conversion stuff here.
        },
        decoration: InputDecoration(
          hintText: "00.00",
          hintStyle: valueStyle.copyWith(color: Colors.white.withOpacity(0.80)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white, width: 1.0, style: BorderStyle.solid)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white, width: 1.0, style: BorderStyle.solid)),
        ),
        style: valueStyle,
      );

  _buildCurrency1Widgets() => Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              // * Add your currency switching magic here.
            },
            child: Row(
              children: <Widget>[
                Text(
                  "USD",
                  style: currencyStyle,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white.withOpacity(.85),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 150,
            height: 55,
            child: _buildInputField(),
          ),
        ],
      );

  _buildCurrency2Widgets() => Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              // * Add your currency switching magic here
            },
            child: Row(
              children: <Widget>[
                Text(
                  "POL",
                  style: currencyStyle,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white.withOpacity(.85),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "69.00",
            style: valueStyle,
          )
        ],
      );

  _buildArrowIcon() => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
          size: 30,
        ),
      );
}
