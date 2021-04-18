import 'package:mercos_challenge/models/client.dart';
import 'package:mercos_challenge/models/product.dart';

class Order {
  final Client client;
  final List<OrderItem> items;
  final double total;

  Order(this.client, this.items, this.total);
}

class OrderItem {
  final Product product;
  final double price;
  final int quantity;

  OrderItem({
    this.product,
    this.price,
    this.quantity,
  });

  double pctDifference() {
    return (((this.price / this.product.price) - 1) * 100);
  }
}
