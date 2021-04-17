import 'package:flutter/material.dart';
import 'package:mercos_challenge/ui/screens/clients_screen.dart';
import 'package:mercos_challenge/ui/screens/products_screen.dart';
import 'package:mercos_challenge/ui/widgets/drawer/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _screenIndex = 0;
  List<Map> _screens = [
    {"title": "Pedidos", "screen": Center(child: Text("Pedidos"))},
    {"title": "Clientes", "screen": ClientsScreen()},
    {"title": "Produtos", "screen": ProductsScreen()}
  ];

  void selectScreen(int screen) {
    setState(() {
      _screenIndex = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            if (_screenIndex == 0)
              IconButton(icon: Icon(Icons.add), onPressed: () {})
          ],
          title: Text(_screens[_screenIndex]["title"]),
          centerTitle: true,
        ),
        drawer: MainDrawer(selectScreen),
        body: _screens[_screenIndex]["screen"]);
  }
}
