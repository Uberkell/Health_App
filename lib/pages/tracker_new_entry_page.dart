import 'package:flutter/material.dart';

class TrackerNewEntryPage extends StatelessWidget{
  TrackerNewEntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    TextField calConsumed = new TextField(
      decoration: InputDecoration(labelText: "Calories Consumed Today"),
      keyboardType: TextInputType.number,
      /* This is where the functionality will be added for filling out the form
        onChanged: (value) {
        //text input
      } */
    );
    TextField waterConsumed = new TextField(
        decoration: InputDecoration(labelText: "Water in Cups Consumed Today"),
        keyboardType: TextInputType.number
    );
    TextField proteinConsumed = new TextField(
        decoration: InputDecoration(labelText: "Protein in Grams Consumed Today"),
        keyboardType: TextInputType.number
    );
    TextField sodiumConsumed = new TextField(
        decoration: InputDecoration(labelText: "Sodium in Grams Consumed Today"),
        keyboardType: TextInputType.number
    );
    TextField fruitsConsumed = new TextField(
        decoration: InputDecoration(labelText: "Servings of Fruit Consumed Today"),
        keyboardType: TextInputType.number
    );
    TextField vegsConsumed = new TextField(
        decoration: InputDecoration(labelText: "Servings of Vegetables Consumed Today"),
        keyboardType: TextInputType.number
    );
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(15),
                  child: calConsumed),
              Padding(padding: EdgeInsets.all(15),
                  child: waterConsumed),
              Padding(padding: EdgeInsets.all(15),
                  child: proteinConsumed),
              Padding(padding: EdgeInsets.all(15),
                  child: sodiumConsumed),
              Padding(padding: EdgeInsets.all(15),
                  child: fruitsConsumed),
              Padding(padding: EdgeInsets.all(15),
                  child: vegsConsumed)
            ],
        ),
        )
    );
  }
}