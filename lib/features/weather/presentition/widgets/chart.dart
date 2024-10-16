import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ActivityLineChart extends StatelessWidget {
  final List<FlSpot> dataPoints;

  ActivityLineChart({required this.dataPoints});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(show: true),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: dataPoints,
              isCurved: false, // You can make it curved or straight
              color: Colors.blue,
              barWidth: 4,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blue.withOpacity(0.3),
              ),
            ),
          ],
          minX: 0,
          maxX: 9,
          minY: 0,
          maxY: 100,
        ),
      ),
    );
  }
}