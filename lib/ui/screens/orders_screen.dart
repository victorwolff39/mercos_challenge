import 'package:flutter/material.dart';
import 'package:mercos_challenge/utils/constants/app_routes.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Nenhum pedido cadastrado",
            style: TextStyle(
              color: Theme.of(context).primaryColor
            ),
          ),
          SizedBox(height: 20),
          FittedBox(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.NEW_ORDER);
              },
              child: Row(
                children: [Icon(Icons.add), Text("Adicionar pedido")],
              ),
            ),
          )
        ],
      ),
    );
  }
}
