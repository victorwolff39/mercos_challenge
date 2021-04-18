import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mercos_challenge/models/client.dart';
import 'package:mercos_challenge/models/product.dart';

class Order {
  final Client client;
  final List<OrderItem> items;
  final double total;

  Order({
    @required this.client,
    @required this.items,
    @required this.total,
  });
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
    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'pt_BR');
    return formatCurrency.format(this.price).toString();
  }
}
