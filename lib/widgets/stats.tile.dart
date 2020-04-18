import 'package:flutter/material.dart';
import 'package:in_covid19_info/widgets/charts/line_chart/mini_line_chart.dart';
import 'package:intl/intl.dart';

final formatter = new NumberFormat("#,###");

class StatsTile extends StatelessWidget {
  StatsTile({
    @required this.label,
    @required this.value,
    this.delta,
    this.seriesData,
    this.color,
  });

  final String label;
  final String value;
  final String delta;
  final Color color;
  final List seriesData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1.0, // soften the shadow
              spreadRadius: 0.5,
            )
          ],
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: TextStyle(fontSize: 16, color: color),
            ),
            SizedBox(
              height: 10,
            ),
            (delta != null)
                ? Text('[+${formatter.format(int.parse(delta))}]',
                    style: TextStyle(color: color, fontSize: 16))
                : Text(''),
            SizedBox(
              height: 5,
            ),
            Text(
              formatter.format(int.parse(value)),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            MiniLineChart(data: seriesData, label: label, color: color),
          ],
        ),
      ),
    );
  }
}
