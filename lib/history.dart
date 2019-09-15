import 'package:flutter/material.dart';
import 'saved_item.dart';

class HistoryPage extends StatelessWidget {
  int itemCount = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Text(
            "History",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 10),
          separatorBuilder: (_, int no) => Divider(),
          itemCount: itemCount,
          itemBuilder: (_, int itemCount) => ListTile(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SavedItem())),
              title: Text(
                itemCount == 0 ? "Bakery Prices in NY" :  itemCount == 1 ? "Walmart Cakes" : itemCount == 2 ? "Starbucks Frappe" : itemCount == 3 ? "Different Strokes": "Prices Waterloo Store",
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
                      "USD -> EUR",
                      style: TextStyle(fontSize: 15),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2),
                    ),
                    Text(
                      "27/08/19",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              )),
        ));
  }
}
