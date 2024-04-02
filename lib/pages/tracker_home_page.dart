import 'package:flutter/material.dart';
import 'package:int_to_win_it/pages/tracker_new_entry_page.dart';

class TrackerHomePage extends StatelessWidget {
  TrackerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ElevatedButton addFood = ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TrackerNewEntryPage()));
      },
      child: const Text("Add Food"),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("What did you eat today?"),
      ),
      body: ListView(
          children: <Widget>[
            ListTile(leading: addFood),
            const ListTile(
                leading: Text("Apple") // will link to database for already added food for the day
                )
          ]
      )
    );
  }
}