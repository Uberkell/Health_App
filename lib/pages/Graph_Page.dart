import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class GraphTest extends StatelessWidget {
  GraphTest({Key? key}) : super(key: key);

  @override
  GraphTest createState() => GraphTest();

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion Line Chart Test',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Syncfusion Line Chart Test'),
        ),
        body: Center(
          child: Container(
            height: 300,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <LineSeries<CalorieData, String>>[
                LineSeries<CalorieData, String>(
                  dataSource: <CalorieData>[
                    CalorieData('Jan', 35),
                    CalorieData('Feb', 28),
                    CalorieData('Mar', 34),
                    CalorieData('Apr', 32),
                    CalorieData('May', 40),
                  ],
                  xValueMapper: (CalorieData calories, _) => calories.month,
                  yValueMapper: (CalorieData calories, _) => calories.calories,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CalorieData {
  CalorieData(this.month, this.calories);
  final String month;
  final double calories;
}