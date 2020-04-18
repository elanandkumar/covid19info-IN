import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MiniLineChart extends StatelessWidget {
  MiniLineChart({@required this.data, this.label, this.color});
  final Color color;
  final List data;
  final String label;

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
          spots: _getSpotsData(),
          isCurved: true,
          barWidth: 3,
          dotData: FlDotData(show: false),
          colors: [color]),
    ];

    return AspectRatio(
      aspectRatio: 4,
      child: LineChart(
        LineChartData(
          lineBarsData: lineBarsData,
          minY: 0,
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
              showTitles: false,
            ),
            bottomTitles: SideTitles(
              showTitles: false,
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(
            show: false,
          ),
        ),
      ),
    );
  }

  List<FlSpot> _getSpotsData() {
    List<FlSpot> spotsData = List();
    int counter = 0;
    if (data != null) {
      data.skip(data.length - 20).forEach((d) {
        double value;
        double dailyConfirmed = double.parse(d['dailyconfirmed']);
        double dailyRecovered = double.parse(d['dailyrecovered']);
        double dailyDeceased = double.parse(d['dailydeceased']);
        print('$dailyConfirmed || $dailyRecovered || $dailyDeceased');
        switch (label) {
          case "Confirmed":
            value = dailyConfirmed;
            break;
          case "Active":
            value = dailyConfirmed - dailyRecovered - dailyDeceased;
            print('daily active $value');
            break;
          case "Recovered":
            value = double.parse(d['totalrecovered']);
            break;
          case "Deceased":
            value = double.parse(d['totaldeceased']);
            break;
          default:
            value = 0;
        }
        spotsData.add(FlSpot(counter.toDouble(), value));
        counter++;
      });
    } else {
      spotsData.add(FlSpot(0, 0));
    }

    return spotsData;
  }
}
