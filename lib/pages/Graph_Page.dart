import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphTest extends StatelessWidget {
  GraphTest({Key? key}) : super(key: key);
  @override
  GraphTest createState() => GraphTest();

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'History Graph',
      home: Scaffold(
        appBar: AppBar(
          title: Text('History Graph'),
        ),
        body: Center(
          child: Container(
            height: 300,
            child: TheLineChart(),
          ),
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
      stream: _firestore.collection('Dates').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        List<CalorieData> data = [];
        snapshot.data!.docs.forEach((doc) {
          CollectionReference caloriesCollection = doc.reference.collection('calories');
          caloriesCollection.get().then((caloriesSnapshot) {
            double totalCalories = 0.0;
            caloriesSnapshot.docs.forEach((caloriesDoc) {
              totalCalories += caloriesDoc['calories'];
            });

            String day = doc.id.substring(0, 2);
            String month = doc.id.substring(3, 5);
            String year = doc.id.substring(6);

            String label = '$day/$month/$year';

            data.add(CalorieData(label, totalCalories));
            setState(() {});
          });
        });

        return SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: <LineSeries<CalorieData, String>>[
            LineSeries<CalorieData, String>(
              dataSource: data,
              xValueMapper: (CalorieData calories, _) => calories.date,
              yValueMapper: (CalorieData calories, _) => calories.calories,
            ),
          ],
        );
      },
    );
  }
}

class CalorieData {
  CalorieData(this.date, this.calories);
  final String date;
  final double calories;
}