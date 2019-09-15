import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  int itemCount = 20;
  @override
  Widget build(BuildContext context) {
    Widget sampleTile = ListTile(
      // contentPadding: EdgeInsets.all(15),
      title: Text(
        "Alcohol LA Prices",
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Wrap(
          // crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 5,
          children: <Widget>[
            Text("USD -> MUR"),
            Text("17/08/19"),
          ],
        ),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Text(
            "History",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.more_vert),
          //     onPressed: () {
          //       // implement
          //     },
          //   )
          // ],
        ),
        body: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 10),
          separatorBuilder: (_, int no) => Divider(),
          itemCount: itemCount,
          itemBuilder: (_, int itemCount) => ListTile(
              title: Text(
                "Alcohol LA Prices",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "USD -> MUR",
                      style: TextStyle(fontSize: 15),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2),
                    ),
                    Text(
                      "17/08/19",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              )),
        ));
  }
}
