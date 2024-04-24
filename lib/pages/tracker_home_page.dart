import 'package:flutter/material.dart';
import 'package:int_to_win_it/pages/tracker_new_entry_page.dart';
import 'package:int_to_win_it/pages/tracker_history_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:int_to_win_it/pages/Graph_Page.dart';

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
  final nameController = TextEditingController();

  bool hasGoal = false;

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
    );

    final calGoalController = TextEditingController();
    final proteinGoalController = TextEditingController();
    final sodiumGoalController = TextEditingController();
    final waterGoalController = TextEditingController();
    final vegGoalController = TextEditingController();
    final fruitGoalController = TextEditingController();


    CircularProgressIndicator calProgress = CircularProgressIndicator();
    CircularProgressIndicator waterProgress= CircularProgressIndicator();
    CircularProgressIndicator sodiumProgress = CircularProgressIndicator();
    CircularProgressIndicator proteinProgress = CircularProgressIndicator();
    CircularProgressIndicator fruitProgress = CircularProgressIndicator();
    CircularProgressIndicator vegProgress = CircularProgressIndicator();

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
                          TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the new calorie goal';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    label: Center(child: Text("New Calorie Goal"))),
                                keyboardType: TextInputType.number,
                                controller: calGoalController,
                              ),
                          TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the new calorie goal';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    label: Center(child: Text("New Water Goal in Cups"))),
                                keyboardType: TextInputType.number,
                                controller: waterGoalController,
                              ),
                          TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the new protein goal in grams';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    label: Center(child: Text("New Protein Goal in Grams"))),
                                keyboardType: TextInputType.number,
                                controller: proteinGoalController,
                              ),
                          TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the new sodium goal in milligram';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    label: Center(child: Text("New Sodium Goal in Mg"))),
                                keyboardType: TextInputType.number,
                                controller: sodiumGoalController,
                              ),
                    TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the new vegetables goal in servings';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    label: Center(child: Text("New Vegetables Goal in Servings"))),
                                keyboardType: TextInputType.number,
                                controller: vegGoalController,
                              ),
                          TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the new fruit goal in servings';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    label: Center(child: Text("New Fruit Goal in Servings"))),
                                keyboardType: TextInputType.number,
                                controller: fruitGoalController,
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
                                  final collection = foodCollection.doc("Set new goal");
                                  await collection.set({
                                    'Calorie Goal': calGoalController.text,
                                    'Water Goal': waterGoalController.text,
                                    'Protein Goal': proteinGoalController.text,
                                    'Sodium Goal': sodiumGoalController.text,
                                    'Fruit Goal': fruitGoalController.text,
                                    'Vegetable Goal': vegGoalController.text,
                                  }
                                  );
                                  message = 'Entry sent successfully';
                                  hasGoal = true;
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
      child: const Text("Set Goals"),
    );


    //if(hasGoal) { //doesn't work
      calProgress = CircularProgressIndicator(
        value: 400 / 2000,
        color: Colors.green,);

      waterProgress = CircularProgressIndicator(
          value: 8 / 15,
          color: Colors.green);

      sodiumProgress = CircularProgressIndicator(
          value: 1400 / 2300,
          color: Colors.green);

      proteinProgress = CircularProgressIndicator(
          value: 80 / 100,
          color: Colors.green);

      fruitProgress = CircularProgressIndicator(
          value: 3 / 4,
          color: Colors.green);

      vegProgress = CircularProgressIndicator(
          value: 2 / 4,
          color: Colors.green);


    return Scaffold(
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
                        calProgress
                        ])),
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