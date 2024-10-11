import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ActivityLineChart extends StatelessWidget {
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
              spots: [
                FlSpot(0, 30),
                FlSpot(1, 40),
                FlSpot(2, 50),
                FlSpot(3, 80),
                FlSpot(4, 90),
                FlSpot(5, 70),
                FlSpot(6, 100),
                FlSpot(7, 60),
                FlSpot(8, 80),
                FlSpot(9, 90),
              ],
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