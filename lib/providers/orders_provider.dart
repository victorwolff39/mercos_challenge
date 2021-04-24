import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import '../models/client.dart' as client;
import '../models/order.dart';
import '../models/product.dart';
import '../utils/constants/firebase_endpoints.dart';

class OrdersProvider with ChangeNotifier {
  final String _ordersUrl = Endpoints.ORDERS;
  List<Order> _items = [];

  List<Order> get items => [..._items];

  Future<void> loadOrders() async {
    List<Order> loadedItems = [];
    final response = await get(Uri.parse('$_ordersUrl.json'));
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
    /*
     * Ordenar a lista por data
     */
    loadedItems.sort((a, b) => a.date.compareTo(b.date));
    _items = loadedItems.reversed.toList();
    return Future.value();
  }

  Future<String> addOrder(Order order) async {
    try {
      await post(Uri.parse('$_ordersUrl.json'),
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

  Future<String> deleteOrder(Order order) async {
    try {
      await delete(
        Uri.parse('$_ordersUrl/${order.id}.json'));
      notifyListeners();
      _items.removeWhere((element) => element.id == order.id);
      return null;
    } catch (error) {
      return "Erro desconhecido.";
    }
  }

  Future<String> editOrder(Order order) async {
    /*
     * Como o id do Firebase não é importante para nenhum procedimento interno da
     * aplicação, não tem problema deletar o pedido e cadastra-lo novamente com a mesma data.
     */
    try {
      deleteOrder(order);
      addOrder(order);
      notifyListeners();
      return null;
    } catch (error) {
      return "Erro desconhecido.";
    }
  }

  int itemsCount() {
    return _items.length;
  }
}
