import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TrackerNewEntryPage extends StatelessWidget {
  TrackerNewEntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("What did you eat today?"),
        ),
        body: Scaffold(body: MyCustomForm()));
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final calsController = TextEditingController();
  final proteinController = TextEditingController();
  final vegController = TextEditingController();
  final fruitController = TextEditingController();
  final sodiumController = TextEditingController();
  final waterController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    calsController.dispose();
    proteinController.dispose();
    sodiumController.dispose();
    vegController.dispose();
    fruitController.dispose();
    waterController.dispose();
    super.dispose();
  }

  List<String> menuItems = ["Grams", "Milligrams", "Ounces"];

  String calorieUnits = "Grams";
  String sodiumUnits = "Grams";
  String proteinUnits = "Grams";
  String vegUnits = "Grams";
  String fruitUnits = "Grams";

  @override
  Widget build(BuildContext context) {

    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: ListView(children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(children: [
                Expanded(
                    child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name of the food';
                    }
                    return null;
                  },
                  decoration: InputDecoration(label: Center(child: Text("Name of Food"))),
                  keyboardType: TextInputType.text,
                  controller: nameController,
                )),
              ])),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child:
                Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          calsController.text = "0";
                        }
                        return null;
                      },
                  decoration:
                      InputDecoration(label: Center(child: Text("Calories Consumed"))),
                  keyboardType: TextInputType.number,
                  controller: calsController,
                )),
              ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(children: [
                Expanded(
                    child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      proteinController.text = "0";
                    }
                    return null;
                  },
                  decoration: InputDecoration(label: Center(child: Text("Protein Consumed"))),
                  keyboardType: TextInputType.number,
                  controller: proteinController,
                )),
                DropdownButton<String>(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  value: proteinUnits,
                  onChanged: (String? newValue) {
                    setState(() {
                      proteinUnits = newValue!;
                    });
                  },
                  items:
                  menuItems.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ])),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(children: [
                Expanded(
                    child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      sodiumController.text = "0";
                    }
                    return null;
                  },
                  decoration: InputDecoration(label: Center(child: Text("Sodium Consumed"))),
                  keyboardType: TextInputType.number,
                  controller: sodiumController,
                )),
                DropdownButton<String>(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  value: sodiumUnits,
                  onChanged: (String? newValue) {
                    setState(() {
                      sodiumUnits = newValue!;
                    });
                  },
                  items:
                  menuItems.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ])),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(children: [
                Expanded(
                    child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      fruitController.text = "0";
                    }
                    return null;
                  },
                  decoration: InputDecoration(label: Center(child: Text("Fruit Consumed"))),
                  keyboardType: TextInputType.number,
                  controller: fruitController,
                )),
                DropdownButton<String>(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  value: fruitUnits,
                  onChanged: (String? newValue) {
                    setState(() {
                      fruitUnits = newValue!;
                    });
                  },
                  items:
                  menuItems.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ])),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(children: [
                Expanded(
                    child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      vegController.text = "0";
                    }
                    return null;
                  },
                  decoration: InputDecoration(label: Center(child: Text("Vegetables Consumed"))),
                  keyboardType: TextInputType.number,
                  controller: vegController,
                )),
                DropdownButton<String>(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  value: vegUnits,
                  onChanged: (String? newValue) {
                    setState(() {
                      vegUnits = newValue!;
                    });
                  },
                  items:
                  menuItems.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ])),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  String message;
                  try {

                    final collection1 = FirebaseFirestore.instance
                        .collection('Users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection('Dates')
                        .doc(todayDate());

                    await collection1.set({
                      'instantiated': "1",
                    });

                    final collection2 = FirebaseFirestore.instance
                        .collection('Users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection('Dates')
                        .doc(todayDate())
                        .collection('Food_and_Water')
                        .doc(nameController.text);

                    await collection2.set({
                      'calories': calsController.text,
                      'protein': proteinController.text,
                      'sodium': sodiumController.text,
                      'fruit': fruitController.text,
                      'vegetables': vegController.text,
                    });
                    message = 'Entry sent successfully';
                  } catch (e) {
                    message = 'Error when sending entry';
                  }

                  // Show a snackbar with the result
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message)));
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ]));
  }

  String todayDate(){
    DateTime today = DateTime.now();
    String dateStr = "${today.month}-${today.day}-${today.year}";

    return dateStr;
  }

  String convertToGrams(String oldValue, String oldUnit){
    var newValue;
    var numVal = int.parse(oldValue);

    if(oldUnit == "Grams"){
      newValue = oldValue;
    } else if(oldUnit == "Milligrams") {
      newValue = numVal * 1000;
    } else if(oldUnit == "Ounces") {
      newValue = numVal * 28.3495231;
    }
    return newValue.toString();
  }
}
