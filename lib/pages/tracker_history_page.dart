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

  /*
  Future<List<Widget>> retrieveHistory() async {
    final userid = FirebaseAuth.instance.currentUser?.uid;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userid)
        .collection('Meal Tracking')
        .get();
    List<Widget> pastFoods = [];
  }
}
class AddData extends StatelessWidget {

   @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           backgroundColor: Colors.green,

        title: Text("geeksforgeeks"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('data').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
               if (!snapshot.hasData){

            return Center(
              child: CircularProgressIndicator(),
            );

}
          return ListView(
            children: snapshot.data.docs.map((document) {
                       return Container(
                child: Center(child: Text(document['text'])),
              );
              }).toList(),
          );},
      ),
    );
    }

} */
