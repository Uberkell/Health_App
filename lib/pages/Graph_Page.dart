import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphTest extends StatelessWidget {
  GraphTest({Key? key}) : super(key: key);
  @override
  GraphTest createState() => GraphTest();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('History Graph'),
        ),
        body: Center(
          child: Container(
            height: 300,
            child: TheLineChart(),
          ),
        ),
    );
  }
}

class TheLineChart extends StatefulWidget {
  @override
  LineChartState createState() => LineChartState();
}


class LineChartState extends State<TheLineChart> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Dates').snapshots(), // Changed collection name to 'Dates'
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        List<CaloriesData> data = [];
        snapshot.data!.docs.forEach((doc) {
          String date = doc.id;
          print('Date: $date');

          CollectionReference foodAndWaterCollection = doc.reference.collection('Food_and_Water');
          foodAndWaterCollection.get().then((foodAndWaterSnapshot) {
            double totalCalories = 0.0;
            foodAndWaterSnapshot.docs.forEach((foodAndWaterDoc) {
              // Convert the string calories to double
              double calories = double.parse(foodAndWaterDoc['calories']);
              totalCalories += calories;
            });
            print('Total Calories for $date: $totalCalories');

            data.add(CaloriesData(date, totalCalories));
            setState(() {});
          });
        });

        return SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: <LineSeries<CaloriesData, String>>[
            LineSeries<CaloriesData, String>(
              dataSource: data,
              xValueMapper: (CaloriesData calories, _) => calories.date,
              yValueMapper: (CaloriesData calories, _) => calories.calories,
            ),
          ],
        );
      },
    );
  }
}

class CaloriesData {
  CaloriesData(this.date, this.calories);
  final String date;
  final double calories;
}