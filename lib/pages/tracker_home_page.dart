import 'package:flutter/material.dart';
import 'package:int_to_win_it/pages/tracker_new_entry_page.dart';
import 'package:int_to_win_it/pages/tracker_history_page.dart';

class TrackerHomePage extends StatelessWidget {
  const TrackerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ElevatedButton addFood = ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TrackerNewEntryPage()));
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
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
                                backgroundColor: MaterialStateProperty.all(Colors.green),
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
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      child: const Text("Add Water"),
    );

    FloatingActionButton seeHistory = FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TrackerHistoryPage()));
      },
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      label: const Text("See Past History"),
    );

    ElevatedButton setGoal = ElevatedButton(
      onPressed: () {
        showDialog(context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,
                title: const Text('Setting Goals'),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                        children: [
                          DropdownButton(
                              value: Text("Select") ,
                              items: [
                                DropdownMenuItem(child: Text("Worm"), value: "One",),
                                DropdownMenuItem(child: Text("Catepillar"), value: "Two",),
                                DropdownMenuItem(child: Text("Cacoon"), value: "Three",),
                                DropdownMenuItem(child: Text("Butterfly"), value: "Four",),
                  ],
                          onChanged: null),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.green),
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
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      child: const Text("Set Goals"),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("What did you eat today?"),
      ),
      body: Stack(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [addFood, addWater]), // Need addFood, addWater, and setGoalseeHistory
        ]
      ),
      floatingActionButton: seeHistory,
    );
  }
}