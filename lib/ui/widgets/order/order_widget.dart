import 'package:flutter/material.dart';
import 'package:mercos_challenge/models/order.dart';

class OrderWidget extends StatelessWidget {
  final Order order;

  OrderWidget(this.order);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(order.client.id.toString()),
          Text(order.client.name),
          Text(order.total.toString()),
        ],
      ),
    );
  }
}
