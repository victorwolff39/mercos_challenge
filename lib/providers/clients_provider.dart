import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/client.dart';
import '../utils/constants/firebase_endpoints.dart';

class ClientsProvider with ChangeNotifier {
  final String _clientsUrl = Endpoints.CLIENTS;
  List<Client> _items = [];

  List<Client> get items => [..._items];

  Future<void> loadClients() async {
    final response = await http.get('$_clientsUrl.json');
    List<dynamic> data = json.decode(response.body);
    _items.clear();

    data.forEach((element) {
      if(element != null) {
        Map<String, dynamic> data = element;
        Client client = Client(
            id: data['id'],
            name: data['name'],
          imageUrl: data['imageUrl'],
        );
        _items.add(client);
        notifyListeners();
      }
    });
    return Future.value();
  }

  int itemsCount() {
    return _items.length;
  }
}
