import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GraphTest extends StatelessWidget {
  GraphTest({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Graph'),
      ),
      body: Center(
        child: Container(
          height: 300,
          child: FirebaseLineChart(),
        ),
      ),
    );
  }
}

class FirebaseLineChart extends StatefulWidget {
  @override
  _FirebaseLineChartState createState() => _FirebaseLineChartState();
}

class _FirebaseLineChartState extends State<FirebaseLineChart> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? uid;

  @override
  void initState() {
    super.initState();
    retrieveUID();
  }

  void retrieveUID() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        uid = user.uid;
      });
    } else {
      setState(() {
        uid = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String dateStr = "${today.month}-${today.day}-${today.year}";
    return StreamBuilder<QuerySnapshot>(

      stream: _firestore.collection('Users').doc(uid).collection('Dates').doc(dateStr).collection('Food_and_Water').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || uid == null) {
          return CircularProgressIndicator();
        }

        List<CaloriesData> data = [];
        snapshot.data!.docs.forEach((doc) {
          String date = doc.id;
          double totalCalories = 0.0;
          (doc.data() as Map<String, dynamic>).forEach((key, value) {
            if (key != 'date') {
              totalCalories += double.parse(value.toString());
            }
          });
          data.add(CaloriesData(date, totalCalories));
        });

        return SfCartesianChart(
          primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Dates')),
          primaryYAxis: NumericAxis(title: AxisTitle(text: 'Total Calories')),
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