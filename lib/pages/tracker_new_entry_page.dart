import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:firebase_auth/firebase_auth.dart';

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
                decoration: InputDecoration(labelText: "Name of Food"),
                keyboardType: TextInputType.number,
              )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Calories Consumed Today"),
                keyboardType: TextInputType.number
              /*onChanged: (value) {};*/
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Protein in Grams Consumed Today"),
                  keyboardType: TextInputType.number),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Sodium in Grams Consumed Today"),
                  keyboardType: TextInputType.number),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Servings of Fruit Consumed Today"),
                keyboardType: TextInputType.number),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Servings of Vegetables Consumed Today"),
                  keyboardType: TextInputType.number),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {

                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Uploading Data')),
                  );
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