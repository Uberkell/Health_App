import 'package:flutter/material.dart';
import 'package:int_to_win_it/pages/tracker_new_entry_page.dart';

class TrackerHomePage extends StatelessWidget {
  const TrackerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ElevatedButton addFood = ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TrackerNewEntryPage()));
      },
      child: const Text("Add Food"),
    );

    ElevatedButton addWater = ElevatedButton(
      onPressed: () {
        showDialog(context: context,
            builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Water Drank'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                    children: [TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Water Drank in Cups',
                      ),
                    )
                    ]
                ),
              ),
            ),
          );
        }
        );
      },
      child: const Text("Add Water"),
    );
    // need to add submit button

    return Scaffold(
      appBar: AppBar(
        title: const Text("What did you eat today?"),
      ),
      body: ListView(
          children: <Widget>[
            ListTile(
                title: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [addFood, addWater])),
            const ListTile(leading: Text("Apple")) // will link to database for already added food for the day
          ]
      )
    );
  }
}