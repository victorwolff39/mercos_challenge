import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:mercos_challenge/models/product.dart';
import 'package:mercos_challenge/utils/constants/firebase_endpoints.dart';

class ProductsProvider with ChangeNotifier {
  final String _productsUrl = Endpoints.PRODUCTS;
  List<Product> _items = [];

  List<Product> get items => [..._items];

  Future<void> loadProducts() async {
    final response = await get('$_productsUrl.json');
    List<dynamic> data = json.decode(response.body);
    _items.clear();

    data.forEach((element) {
      if(element != null) {
        Map<String, dynamic> data = element;
        Product product = Product(
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
    return Future.value();
  }

  int itemsCount() {
    return _items.length;
  }
}
