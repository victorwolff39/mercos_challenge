import 'package:flutter/material.dart';
import 'package:mercos_challenge/services/authentication.dart';

class MainDrawer extends StatelessWidget {
  final Function(int) select;

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
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedidos'),
            onTap: () {
              select(0);
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.account_box_rounded),
            title: Text('Clientes'),
            onTap: () {
              select(1);
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Produtos'),
            onTap: () {
              select(2);
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
