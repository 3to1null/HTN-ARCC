import 'package:flutter/material.dart';

class Calculator extends StatelessWidget {
  final currencyStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20);
  final TextEditingController inputController = TextEditingController();
  final valueStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w200, fontSize: 50);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(
          "Calculate Currency",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 10.0, // has the effect of softening the shadow
                  spreadRadius: 0.2, // has the effect of extending the shadow
                  offset: Offset(
                    2.5, // horizontal, move right 10
                    2.5, // vertical, move down 10
                  ),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(50)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF00FF9C), Color(0xFF1CD0A2)],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "USD",
                      style: currencyStyle,
                    ),
                    TextField(
                      cursorColor: Colors.white,
                      controller: inputController,
                      decoration: InputDecoration(
                          labelText: "Hello",
                          labelStyle: theme.textTheme.caption
                              .copyWith(color: Colors.white),),
                    ), // ! Not working
                    // Text(
                    //   "69.00",
                    //   style: valueStyle,
                    // )
                    // Add rest of currency 1 widgets
                  ],
                ),
                IconButton(
                  onPressed: () {
                    // Implement switch
                  },
                  icon: Icon(
                    Icons.swap_horiz,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text("POL", style: currencyStyle),
                    Text(
                      "69.00",
                      style: valueStyle,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
