import 'package:flutter/cupertino.dart';
import '../models/client.dart';
import '../models/product.dart';
import '../utils/number_formatter.dart';

class Order {
  final String id;
  final Client client;
  final List<OrderItem> items;
  final double total;
  final DateTime date;

  Order({
    this.id,
    @required this.client,
    @required this.items,
    @required this.total,
    this.date
  });

  String formattedTotal() {
    return NumberFormatter.formatPrice(this.total);
  }
}

class OrderItem {
  final Product product;
  final double price;
  final int quantity;
  final double rentability;

  OrderItem({
    @required this.product,
    @required this.price,
    this.quantity,
    this.rentability,
  });

  double pctDifference() {
    return (((this.price / this.product.price) - 1) * 100);
  }

  String formattedPrice() {
    return NumberFormatter.formatPrice(this.price);
  }
}
