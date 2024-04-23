import 'package:flutter/material.dart';
import 'package:int_to_win_it/pages/Graph_Page.dart';
import 'package:int_to_win_it/pages/tracker_new_entry_page.dart';
import 'package:int_to_win_it/pages/tracker_history_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

    String todayDate(){
      DateTime today = DateTime.now();
      String dateStr = "${today.month}-${today.day}-${today.year}";

      return dateStr;
    }

    TextEditingController waterController = TextEditingController();
    TextEditingController unitController = TextEditingController();

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
                          controller: waterController,
                          decoration: const InputDecoration(
                            labelText: 'Water Drank in Cups',
                          ),
                        ),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.green),
                                foregroundColor: MaterialStateProperty.all(Colors.white),
                              ),
                              onPressed: () async {
                                String message;
                                try {
                                  //final collection = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).collection(todayDate()).doc("water");
                                  final usersCollection = FirebaseFirestore.instance.collection('Users');
                                  final userId = FirebaseAuth.instance.currentUser?.uid;
                                  final userDocRef = usersCollection.doc(userId);
                                  final dateEntry = todayDate();
                                  final userDateCollection = userDocRef.collection('Dates').doc(dateEntry);
                                  final foodCollection = userDateCollection.collection('Food_and_Water');
                                  final foodItem =foodCollection.doc('water');
                                  await foodItem.set({
                                    'waterDrank': waterController.text,
                                    'units': unitController.text,
                                  }
                                  );
                                  message = 'Entry sent successfully';
                                } catch (e) {
                                  message = 'Error when sending entry';
                                }
                                // Show a snackbar with the result
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
      heroTag: "btn1",
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TrackerHistoryPage()));
      },
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      label: const Text("Past History"),
    );

    FloatingActionButton seeGraph = FloatingActionButton.extended(
      heroTag: "btn2",
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => GraphTest()));
      },
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      label: const Text("See Graph"),
    );

    String curGoal = "Calories";
    final goalController = TextEditingController();
    List<String> diffGoals = ["Calories", "Protein", "Vegetables", "Fruit", "Sodium"];
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
                        children: [Row(children: [
                          DropdownButton<String>(
                            value: curGoal,
                            onChanged: (String? newValue) {
                              curGoal = newValue!;
                            },
                            items:  diffGoals.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the new goal';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(label: Center(child: Text("New Goal"))),
                                keyboardType: TextInputType.number,
                                controller: goalController,
                              )),]),
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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [addFood, addWater, setGoal],
          ),
          Expanded(child: Container()), // Placeholder to push other content to the bottom
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, bottom: 16.0),
              child: seeHistory,

            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only( right: 3.0, bottom: 16.0),
              child: seeGraph,
            ),
          ),
        ],
      ),
    );
  }
}