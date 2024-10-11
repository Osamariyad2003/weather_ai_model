import 'package:flutter/material.dart';

Widget buildDayButton(String day, String date, {bool selected = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: Column(
      children: [
        Text(
          day,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: selected ? Colors.blue : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey),
          ),
          child: Text(
            date,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}

 Widget buildStatistic(String value, String label) {
  return Column(
    children: [
      // Circular Container for value
      Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.blueAccent, // Add a border to match the design
            width: 4,
          ),
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      SizedBox(height: 8), // Space between the value and label
      Text(
        label,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
    ],
  );
}