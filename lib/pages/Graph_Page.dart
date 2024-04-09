import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class GraphTest extends StatelessWidget {
  GraphTest({Key? key}) : super(key: key);

  @override
  GraphTest createState() => GraphTest();

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test Graph'),
        ),
        body: LineChartWidget(),
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<MyData> data = [
      MyData(DateTime(2022, 1, 1), 10),
      MyData(DateTime(2022, 1, 2), 20),
      MyData(DateTime(2022, 1, 3), 15),
      MyData(DateTime(2022, 1, 4), 25),
      MyData(DateTime(2022, 1, 5), 30),
    ];

    final List<charts.Series<MyData, DateTime>> seriesList = [
      charts.Series<MyData, DateTime>(
        id: 'Data',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (MyData data, _) => data.timestamp,
        measureFn: (MyData data, _) => data.value,
        data: data,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300, // height adjustment
        width: double.infinity, // Width adjustment
        child: charts.TimeSeriesChart(
          seriesList,
          animate: true,
          dateTimeFactory: const charts.LocalDateTimeFactory(),
        ),
      ),
    );
  }
}


class MyData {
  final DateTime timestamp;
  final int value;

  MyData(this.timestamp, this.value);
}