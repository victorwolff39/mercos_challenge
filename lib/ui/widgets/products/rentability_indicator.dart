import 'package:flutter/material.dart';
import '../../../models/order.dart';

class RentabilityIndicator extends StatelessWidget {
  final OrderItem orderItem;

  RentabilityIndicator(this.orderItem);

  IconData iconData;
  Color color;

  @override
  Widget build(BuildContext context) {
    if (this.orderItem.rentability > 0) {
      iconData = Icons.keyboard_arrow_up;
      color = Colors.green;
    } else {
      iconData = Icons.keyboard_arrow_down;
      color = Colors.red;
    }

    return Row(
      children: [
        if (orderItem.rentability != 0)
          Icon(
            iconData,
            color: color,
            size: 24,
          ),
        SizedBox(width: 4),
        Text(
          "${orderItem.rentability.toString()}%",
          style: TextStyle(color: color),
        )
      ],
    );
  }
}
