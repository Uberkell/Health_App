import 'package:flutter/material.dart';
import 'package:int_to_win_it/pages/tracker_new_entry_page.dart';
import 'package:int_to_win_it/pages/tracker_history_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TrackerHomePage extends StatelessWidget {
  const TrackerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("What did you eat today?"),
        ),
        body: Scaffold(body: UpdatingTrackerHomePage()));
  }
}

class UpdatingTrackerHomePage extends StatefulWidget {
  const UpdatingTrackerHomePage({super.key});

  @override
  UpdatedState createState() {
    return UpdatedState();
  }
}

class UpdatedState extends State<UpdatingTrackerHomePage> {
  // Create a global key that uniquely identifies the Form widget
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ElevatedButton addFood = ElevatedButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TrackerNewEntryPage()));
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      child: const Text("Add Food"),
    );

    String todayDate() {
      DateTime today = DateTime.now();
      String dateStr = "${today.month}-${today.day}-${today.year}";

      return dateStr;
    }

    TextEditingController waterController = TextEditingController();
    TextEditingController unitController = TextEditingController();
    int waterIndex = 0;

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
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.green),
                                foregroundColor: MaterialStateProperty.all(
                                    Colors.white),
                              ),
                              onPressed: () async {
                                String message;
                                try {
              final usersCollection = FirebaseFirestore.instance.collection('Users');
              final userId = FirebaseAuth.instance.currentUser?.uid;
              final userDocRef = usersCollection.doc(userId);
              final dateEntry = todayDate();
              final userDateCollection = userDocRef.collection('Dates').doc(dateEntry);
              final foodCollection = userDateCollection.collection('Food_and_Water');
                                  final collection = foodCollection.doc("water $waterIndex");
                                  await collection.set({
                                    'waterDrank': waterController.text,
                                    'units': unitController.text,
                                  }
                                  );
                                  message = 'Entry sent successfully';
                                  waterIndex += 1;
                                } catch (e) {
                                  message = 'Error when sending entry';
                                }
                                // Show a snackbar with the result
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)));
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TrackerHistoryPage()));
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
      label: const Text("See Past History"),
    );

    String curGoal = "Calories";
    final goalController = TextEditingController();
    List<String> diffGoals = [
      "Calories",
      "Protein",
      "Vegetables",
      "Fruit",
      "Sodium"
    ];
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
                            items: diffGoals.map<DropdownMenuItem<String>>((
                                String value) {
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
                                decoration: InputDecoration(
                                    label: Center(child: Text("New Goal"))),
                                keyboardType: TextInputType.number,
                                controller: goalController,
                              )),
                        ]),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.green),
                                foregroundColor: MaterialStateProperty.all(
                                    Colors.white),
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

    CircularProgressIndicator calProgress = CircularProgressIndicator(
      value: 10/100,
    color: Colors.green,);

    CircularProgressIndicator waterProgress = CircularProgressIndicator(
      value: 20/100,
        color: Colors.green);

    CircularProgressIndicator sodiumProgress = CircularProgressIndicator(
      value: 30/100,
        color: Colors.green);

    CircularProgressIndicator proteinProgress = CircularProgressIndicator(
      value: 40/100,
        color: Colors.green);

    CircularProgressIndicator fruitProgress = CircularProgressIndicator(
      value: 50/100,
        color: Colors.green);

    CircularProgressIndicator vegProgress = CircularProgressIndicator(
      value: 60/100,
        color: Colors.green);

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

      body: Stack(
          children: [
            ListView( children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [addFood, addWater, setGoal]),
            Padding(padding: EdgeInsets.symmetric(vertical: 60),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Transform.scale(
                      scale: 2,
                      child: Column(children: [
                        Text("Calories"),
                        calProgress])),
                  Transform.scale(
                      scale: 2,
                      child: Column(children: [
                        Text("Water"),
                        waterProgress])),
                ],),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 60),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Transform.scale(
                      scale: 2,
                      child: Column(children: [
                        Text("Sodium"),
                        sodiumProgress])),
                  Transform.scale(
                      scale: 2,
                      child: Column(children: [
                        Text("Protein"),
                        proteinProgress])),
                ],),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 60),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Transform.scale(
                      scale: 2,
                      child: Column(children: [
                        Text("Vegetables"),
                        vegProgress])),
                  Transform.scale(
                      scale: 2,
                      child: Column(children: [
                        Text("Fruit"),
                        fruitProgress])),
                ],),
            ),
          ]
      )]),
      floatingActionButton: seeHistory,
    );
  }
}