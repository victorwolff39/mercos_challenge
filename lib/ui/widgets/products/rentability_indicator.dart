import 'package:flutter/material.dart';

class RentabilityIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.keyboard_arrow_up,
          color: Colors.green,
        ),
        Text(
          "8.7%",
          style: TextStyle(color: Colors.green),
        )
      ],
    );
  }
}
