import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrackerHistoryPage extends StatelessWidget {
  const TrackerHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Past History"),
        ),
        body: UpdatingTrackerHistoryPage() //AddData()
        );
  }
}

class UpdatingTrackerHistoryPage extends StatefulWidget {
  const UpdatingTrackerHistoryPage({super.key});

  @override
  UpdatingTrackerHistoryPageState createState() {
    return UpdatingTrackerHistoryPageState();
  }
}

class UpdatingTrackerHistoryPageState extends State<UpdatingTrackerHistoryPage> {
  final usersCollection = FirebaseFirestore.instance.collection('Users');
  final userId = FirebaseAuth.instance.currentUser?.uid;

  Future<List<Widget>> getData() async {
    final userid = FirebaseAuth.instance.currentUser?.uid;

    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userid)
        .collection("Dates").get();

    List<Widget> food = [];

    await Future.forEach(query.docs, (days) async{

      QuerySnapshot queryQuestion = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userid)
          .collection("Dates")
          .doc("4-24-2024") //4-22-2024 rn need to be all
          .collection("Food_and_Water")
          .get();

        List<Widget> tempfood = [];
        await Future.forEach(queryQuestion.docs, (doc) async {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

          if (data != null && data.length > 3) {
            var tempSodium = data.entries.first;
            var tempfruit = data.entries.elementAt(1);
            var tempcal = data.entries.elementAt(2);
            var tempprotein = data.entries.elementAt(3);
            var tempveg = data.entries.elementAt(4);

            tempfood.add(FoodData(
                doc.id, //food name
                days.id, // date
                displayPair(tempSodium.key, tempSodium.value),
                displayPair(tempprotein.key, tempprotein.value),
                displayPair(tempfruit.key, tempfruit.value),
                displayPair(tempveg.key, tempveg.value),
                displayPair(tempcal.key, tempcal.value)
            ));
            setState(() {

            });
          } else if (data != null && data.length < 3){
            var tempWater = data.entries.first;
            food.add(WaterData(doc.id, days.id, displayPair("Water drank", "${tempWater.value} cups")));
          }
        });

        for (var entry in tempfood) {
          food.add(entry);
         }

    });
    return food;
  }

  String displayPair(var label, var value){
    return "$label: $value";
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
        future: getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return SingleChildScrollView(
            child: Column(
              children: snapshot.data!,
            ),
          );
        });
  }
}

class FoodData extends StatelessWidget {
  FoodData(this.name, this.date, this.sodium, this.fruit,
      this.cals, this.protein, this.veg);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name),
              Text(date),
              Text(cals),
              Text(protein),
              Text(sodium),
              Text(veg),
              Text(fruit),
            ]));
  }

  final String date, name, cals, sodium, protein, fruit, veg;
}

class WaterData extends FoodData {
  WaterData(this.water, this.date, this.amount) : super('', '', '', '', '', '', '');

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(date),
              Text(amount.toString())
            ]));
  }

  final String amount, water;
  @override
  final String date;
}