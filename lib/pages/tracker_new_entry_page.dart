import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TrackerNewEntryPage extends StatelessWidget {
  TrackerNewEntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("What did you eat today?"),
        ),
        body: Scaffold(body: MyCustomForm())
    );
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

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,

      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Name of Food"),
                keyboardType: TextInputType.text,
                controller: nameController,
              )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Calories Consumed Today"),
                keyboardType: TextInputType.number,
                controller: calsController,
              /*onChanged: (value) {};*/
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Protein in Grams Consumed Today"),
                keyboardType: TextInputType.number,
                controller: proteinController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Sodium in Grams Consumed Today"),
                keyboardType: TextInputType.number,
                controller: sodiumController,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Servings of Fruit Consumed Today"),
                keyboardType: TextInputType.number,
                controller: fruitController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Servings of Vegetables Consumed Today"),
                keyboardType: TextInputType.number,
                controller: vegController,),
            ),
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
                      // Get a reference to the `food` collection
                      final collection = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).collection('food').doc(nameController.text);

                      // Write the server's timestamp and the user's feedback
                      await collection.set({
                        'calories': calsController.text,
                        'protein': proteinController.text,
                        'sodium': sodiumController.text,
                        'fruit': fruitController.text,
                        'vegetables': vegController.text,
                        //'water': waterController.text,
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
    ]
      )
    );
  }
}