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
                    ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                    onPressed: () {
                      Navigator.pop(context);
                      },
                    child: const Text("Enter")),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("What did you eat today?"),
      ),
      body: ListView(
          children: <Widget>[
            ListTile(
                title: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [addFood, addWater])),
            ListTile(
                leading: Text("Apple")) // will link to database for already added food for the day
          ]
      )
    );


  }
}