import 'package:flutter/material.dart';
import 'package:mercos_challenge/models/order.dart';
import '../../../services/authentication.dart';

class MainDrawer extends StatelessWidget {
  final Function(int, Order) select;

  MainDrawer(this.select);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Bem-Vindo!'),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          SizedBox(height: 8),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Pedidos'),
            onTap: () {
              select(0, null);
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.business),
            title: Text('Clientes'),
            onTap: () {
              select(1, null);
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text('Produtos'),
            onTap: () {
              select(2, null);
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () {
              Authentication().signOut();
            },
          ),
        ],
      ),
    );
  }
}
