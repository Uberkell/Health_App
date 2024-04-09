import 'package:flutter/material.dart';

class TrackerNewEntryPage extends StatelessWidget{
  TrackerNewEntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    ElevatedButton addFood = ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("Add Food"),
    );
    // current problem: this is just a temporary action since it opens a new page instead
    // which causes a problem when entering multiple foods where the user has to back arrow
    // out of every page created between the two to return to the home page
    // also since this hasn't been attached to the database yet, it cannot store or send information

    return Scaffold(
      appBar: AppBar(
        title: const Text("What did you eat today?"),
      ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(8),
                  child: foodName),
              Padding(padding: EdgeInsets.all(12),
                  child: calConsumed),
              Padding(padding: EdgeInsets.all(8),
                  child: proteinConsumed),
              Padding(padding: EdgeInsets.all(8),
                  child: sodiumConsumed),
              Padding(padding: EdgeInsets.all(8),
                  child: fruitsConsumed),
              Padding(padding: EdgeInsets.all(8),
                  child: vegsConsumed),
              Container(),
              Padding(padding: EdgeInsets.all(8),
                  child: addFood)
            ],
          ),
        )
    );
  }

  TextField foodName = const TextField(
      decoration: InputDecoration(labelText: "Name of Food"),
      keyboardType: TextInputType.number
  );
  TextField calConsumed = const TextField(
    decoration: InputDecoration(labelText: "Calories Consumed Today"),
    keyboardType: TextInputType.number,
    /* This is where the functionality will be added for filling out the form
        onChanged: (value) {
        //text input
      } */
  );
  TextField proteinConsumed = const TextField(
      decoration: InputDecoration(labelText: "Protein in Grams Consumed Today"),
      keyboardType: TextInputType.number
  );
  TextField sodiumConsumed = const TextField(
      decoration: InputDecoration(labelText: "Sodium in Grams Consumed Today"),
      keyboardType: TextInputType.number
  );
  TextField fruitsConsumed = const TextField(
      decoration: InputDecoration(labelText: "Servings of Fruit Consumed Today"),
      keyboardType: TextInputType.number
  );
  TextField vegsConsumed = const TextField(
      decoration: InputDecoration(labelText: "Servings of Vegetables Consumed Today"),
      keyboardType: TextInputType.number
  );


}