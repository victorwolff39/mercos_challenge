import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:mercos_challenge/models/order.dart';
import 'package:mercos_challenge/utils/constants/firebase_endpoints.dart';

class OrdersProvider with ChangeNotifier {
  final String _ordersUrl = Endpoints.ORDERS;
  List<Order> _items = [];

  List<Order> get items => [..._items];

  Future<void> loadOrders() async {
    final response = await get('$_ordersUrl.json');
    List<dynamic> data = json.decode(response.body);
    _items.clear();

    /*
    data.forEach((element) {
      if(element != null) {
        Map<String, dynamic> data = element;
        Order order = Order(
            id: data['id'],
            name: data['name'],
            imageUrl: data['imageUrl'],
            price: data['price']
        );

        if(data.containsKey('multiple')) {
          product.multiple = data['multiple'];
        }
        _items.add(product);
        notifyListeners();
      }
    });
    */
    return Future.value();
  }

  int itemsCount() {
    return _items.length;
  }
}
