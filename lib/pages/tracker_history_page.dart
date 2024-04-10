import 'package:flutter/material.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class TrackerHistoryPage extends StatelessWidget {
  const TrackerHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("What did you eat today?"),
        ),
        body: Text("History") //AddData()
    );
  }
}