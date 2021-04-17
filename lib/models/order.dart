import 'package:mercos_challenge/models/client.dart';
import 'package:mercos_challenge/models/product.dart';

class Order {
  final Client client;
  final List<OrderItem> items;

  Order(this.client, this.items);
}

class OrderItem {
  final Product product;
  final double price;
  final int quantity;

  OrderItem(this.product, this.price, this.quantity);
}