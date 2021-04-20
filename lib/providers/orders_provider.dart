import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:mercos_challenge/models/client.dart' as client;
import 'package:mercos_challenge/models/order.dart';
import 'package:mercos_challenge/models/product.dart';
import 'package:mercos_challenge/utils/constants/firebase_endpoints.dart';

class OrdersProvider with ChangeNotifier {
  final String _ordersUrl = Endpoints.ORDERS;
  List<Order> _items = [];

  List<Order> get items => [..._items];

  Future<void> loadOrders() async {
    List<Order> loadedItems = [];
    final response = await get('$_ordersUrl.json');
    Map<String, dynamic> data = json.decode(response.body);

    if (data != null) {
      data.forEach((orderId, orderData) {
        loadedItems.add(Order(
          id: orderId,
          total: orderData['total'],
          date: DateTime.parse(orderData['date']),
          client: client.Client(
              id: orderData['client']['id'],
              name: orderData['client']['name'],
              imageUrl: orderData['client']['imageUrl']),
          items:
              (orderData['items'] as List<dynamic>).map((item) {
                return OrderItem(
                  price: item['price'],
                  quantity: item['quantity'],
                  rentability: item['rentability'],
                  product: Product(
                    id: item['product']['id'],
                    name: item['product']['name'],
                    price: item['product']['price'],
                    imageUrl: item['product']['imageUrl'],
                    multiple: item['product']['multiple']
                  ),
                );
              }).toList(),
        ));
      });
      notifyListeners();
    }
    _items.clear();
    _items = loadedItems.reversed.toList();
    return Future.value();
  }

  Future<String> addOrder(Order order) async {
    try {
      await post(
        '$_ordersUrl.json',
        body: json.encode({
          'total': order.total,
          'date': order.date.toIso8601String(),
          'client': {
            'id': order.client.id,
            'name': order.client.name,
            'imageUrl': order.client.imageUrl
          },
          'items': order.items
              .map((e) => {
                    'price': e.price,
                    'quantity': e.quantity,
                    'rentability': e.rentability,
                    'product': {
                      'id': e.product.id,
                      'name': e.product.name,
                      'price': e.product.price,
                      'multiple': e.product.multiple,
                      'imageUrl': e.product.imageUrl,
                    }
                  })
              .toList()
        }),
      );
      notifyListeners();
      _items.insert(0,
          Order(client: order.client, total: order.total, items: order.items));
      return null;
    } catch (error) {
      return "Erro desconhecido.";
    }
  }

  int itemsCount() {
    return _items.length;
  }
}
